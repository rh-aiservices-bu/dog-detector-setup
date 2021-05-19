#!/usr/bin/env bash
printf "\n\n######## deploy object detection kafka consumer ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


oc project ${OC_PROJECT} 2> /dev/null || oc new-project ${OC_PROJECT}
oc project
oc apply -f "${DIR}/app.yaml"

#oc new-app python:3.8-ubi8~https://github.com/rh-aiservices-bu/object-detection-kafka-consumer.git \
#-l 'app.kubernetes.io/component=object-detection-kafka-consumer' \
#-l 'app.kubernetes.io/instance=object-detection-kafka-consumer' \
#-l 'app.kubernetes.io/part-of=object-detection-kafka-consumer' \
#-o  yaml > "kafka-consumer/sample-app.yaml"

