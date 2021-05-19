#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

oc project ${OC_PROJECT} 2> /dev/null || oc new-project ${OC_PROJECT}
oc project

printf "\n\n######## deploy object detection common data ########\n"

PARAMS=''
if [[ -n "${KAFKA_BOOTSTRAP_SERVER}" ]]; then
  PARAMS="${PARAMS} -p KAFKA_BOOTSTRAP_SERVER=${KAFKA_BOOTSTRAP_SERVER}"
fi
if [[ -n "${KAFKA_SECURITY_PROTOCOL}" ]]; then
  PARAMS="${PARAMS} -p KAFKA_SECURITY_PROTOCOL=${KAFKA_SECURITY_PROTOCOL}"
fi
if [[ -n "${KAFKA_SASL_MECHANISM}" ]]; then
  PARAMS="${PARAMS} -p KAFKA_SASL_MECHANISM=${KAFKA_SASL_MECHANISM}"
fi
if [[ -n "${KAFKA_USERNAME}" ]]; then
  PARAMS="${PARAMS} -p KAFKA_USERNAME=${KAFKA_USERNAME}"
fi
if [[ -n "${KAFKA_PASSWORD}" ]]; then
  PARAMS="${PARAMS} -p KAFKA_PASSWORD=${KAFKA_PASSWORD}"
fi
if [[ -n "${KAFKA_TOPIC_IMAGES}" ]]; then
  PARAMS="${PARAMS} -p KAFKA_TOPIC_IMAGES=${KAFKA_TOPIC_IMAGES}"
fi
if [[ -n "${KAFKA_TOPIC_OBJECTS}" ]]; then
  PARAMS="${PARAMS} -p KAFKA_TOPIC_OBJECTS=${KAFKA_TOPIC_OBJECTS}"
fi
if [[ -n "${OBJECT_DETECTION_URL}" ]]; then
  PARAMS="${PARAMS} -p OBJECT_DETECTION_URL=${OBJECT_DETECTION_URL}"
fi

oc process -f "${DIR}/common.yaml" ${PARAMS} | oc create -f -

