#!/usr/bin/env bash
printf "\n\n######## deploy app ########\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

oc new-app nodejs:14-ubi8~${APP_GIT_REPO} \
--name dog-detector-app \
-l 'app.kubernetes.io/component=dog-detector' \
-l 'app.kubernetes.io/instance=dog-detector' \
-l 'app.kubernetes.io/part-of=dog-detector'

oc create route edge dog-detector-app --service=dog-detector-app
oc set env deployment/dog-detector-app --from=secret/dog-detector-kafka
oc set env deployment/dog-detector-app --from=configmap/dog-detector-service
