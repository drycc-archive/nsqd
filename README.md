# Drycc NSQ
[![Build Status](https://drone.drycc.cc/api/badges/drycc/nsqd/status.svg)](https://drone.drycc.cc/drycc/nsqd)

Drycc (pronounced DAY-iss) Workflow is an open source Platform as a Service (PaaS) that adds a developer-friendly layer to any [Kubernetes](http://kubernetes.io) cluster, making it easy to deploy and manage applications on your own servers.

A NSQ image for running on a kubernetes cluster.

## Description
NSQ is a high performance realtime distributed messaging platform. This image is for running `nsqd` on a kubernetes cluster. It provides no data persistence or the `nsqlookupd` service. Access to the queue is provided through a service ip.
