SHELL = /bin/bash
include includes.mk

DOCKER_HOST = $(shell echo $$DOCKER_HOST)
BUILD_TAG ?= git-$(shell git rev-parse --short HEAD)
SHORT_NAME ?= nsqd
DEPLOYMENT_NAME ?= nsqd
DRYCC_REGISTRY ?= ${DEV_REGISTRY}
IMAGE_PREFIX ?= drycc
PLATFORM ?= linux/amd64,linux/arm64

TEST_ENV_PREFIX := docker run --rm -v ${CURDIR}:/bash -w /bash drycc/go-dev
SHELL_SCRIPTS = $(wildcard rootfs/opt/nsqd/bin/*)

include versioning.mk

build: docker-build
push: docker-push

docker-build:
	docker build ${DOCKER_BUILD_FLAGS} -t ${IMAGE} rootfs
	docker tag ${IMAGE} ${MUTABLE_IMAGE}

docker-buildx:
	docker buildx build --platform ${PLATFORM} -t ${IMAGE} rootfs --push

clean: check-docker
	docker rmi $(IMAGE)

test: test-style

test-style: check-docker
	${TEST_ENV_PREFIX} shellcheck $(SHELL_SCRIPTS)

deploy: check-kubectl docker-build docker-push
	kubectl --namespace=drycc patch deployment drycc-${DEPLOYMENT_NAME} \
		--type='json' \
		-p='[ \
			{"op": "replace", "path": "/spec/strategy", "value":{"type":"Recreate"}}, \
			{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"$(IMAGE)"}, \
			{"op": "replace", "path": "/spec/template/spec/containers/0/imagePullPolicy", "value":"Always"} \
		]'

.PHONY: build push docker-build clean test test-style deploy
