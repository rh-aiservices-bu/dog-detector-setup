#!/usr/bin/env bash
printf "\n\n######## deploy object detection kafka consumer ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


oc project ${OC_PROJECT} 2> /dev/null || oc new-project ${OC_PROJECT}
oc project

oc new-app python:3.8-ubi7~${KAFKA_CONSUMER_GIT_REPO} \
-l 'app.kubernetes.io/component=dog-detector-kafka-consumer' \
-l 'app.kubernetes.io/instance=dog-detector-kafka-consumer' \
-l 'app.kubernetes.io/part-of=dog-detector-kafka-consumer' \
-e KAFKA_BOOTSTRAP_SERVER=${KAFKA_BOOTSTRAP_SERVER} \
-e KAFKA_SECURITY_PROTOCOL=${KAFKA_SECURITY_PROTOCOL} \
-e KAFKA_SASL_MECHANISM=${KAFKA_SASL_MECHANISM} \
-e KAFKA_USERNAME=${KAFKA_USERNAME} \
-e KAFKA_PASSWORD=${KAFKA_PASSWORD} \
-e KAFKA_TOPIC_IMAGES=${KAFKA_TOPIC_IMAGES} \
-e KAFKA_TOPIC_OBJECTS=${KAFKA_TOPIC_OBJECTS}

