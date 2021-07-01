#!/usr/bin/env bash
printf "\n\n######## deploy app ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


oc project ${OC_PROJECT} 2> /dev/null || oc new-project ${OC_PROJECT}
oc project

oc new-app --docker-image=${APP_IMAGE_REPO} \
--name='dog-detector-app' \
-l 'app.kubernetes.io/component=dog-detector-app' \
-l 'app.kubernetes.io/instance=dog-detector-app' \
-l 'app.kubernetes.io/part-of=dog-detector-app' \
-e OBJECT_DETECTION_URL=${OBJECT_DETECTION_URL} \
-e KAFKA_BOOTSTRAP_SERVER=${KAFKA_BOOTSTRAP_SERVER} \
-e KAFKA_SECURITY_PROTOCOL=${KAFKA_SECURITY_PROTOCOL} \
-e KAFKA_SASL_MECHANISM=${KAFKA_SASL_MECHANISM} \
-e KAFKA_USERNAME=${KAFKA_USERNAME} \
-e KAFKA_PASSWORD=${KAFKA_PASSWORD} \
-e KAFKA_TOPIC_IMAGES=${KAFKA_TOPIC_IMAGES} \
-e KAFKA_TOPIC_OBJECTS=${KAFKA_TOPIC_OBJECTS}


oc expose svc/dog-detector-app \
-l 'app.kubernetes.io/component=dog-detector-app' \
-l 'app.kubernetes.io/instance=dog-detector-app' \
-l 'app.kubernetes.io/part-of=dog-detector-app'

oc patch -n ${OC_PROJECT} route dog-detector-app --type=merge -p '{"spec": {"tls": {"termination": "edge", "insecureEdgeTerminationPolicy": "Redirect"} }}'
