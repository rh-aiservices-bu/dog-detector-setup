#!/usr/bin/env bash
printf "\n\n######## deploy object detection rest service ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

oc new-app python:3.8-ubi7~${REST_SERVICE_GIT_REPO} \
-l 'app.kubernetes.io/component=dog-detector' \
-l 'app.kubernetes.io/instance=dog-detector' \
-l 'app.kubernetes.io/part-of=dog-detector'

oc expose svc/dog-detector-service
