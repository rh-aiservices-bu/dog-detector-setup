#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

oc project ${OC_PROJECT} 2> /dev/null || oc new-project ${OC_PROJECT}
oc project

printf "\n\n######## deploy object detection kafka instance ########\n"

oc apply -f "${DIR}/resources/object-detection-kafka.yaml"
oc wait kafka/object-detection --for=condition=Ready --timeout=300s

printf "\n\n######## deploy object detection kafka topics ########\n"

oc apply -f "${DIR}/resources/images-topic.yaml"
oc apply -f "${DIR}/resources/objects-topic.yaml"


