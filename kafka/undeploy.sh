#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
oc project ${OC_PROJECT} && \
oc delete -f "${DIR}/resources/images-topic.yaml" && \
oc delete -f "${DIR}/resources/objects-topic.yaml" && \
oc delete -f "${DIR}/resources/object-detection-kafka.yaml"


