DEFAULT_ENV_FILE := .env
ifneq ("$(wildcard $(DEFAULT_ENV_FILE))","")
include ${DEFAULT_ENV_FILE}
export $(shell sed 's/=.*//' ${DEFAULT_ENV_FILE})
endif

ENV_FILE := .env.local
ifneq ("$(wildcard $(ENV_FILE))","")
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
endif


##################################

.PHONY: deploy
deploy: deploy-kafka deploy-common deploy-app deploy-rest-service deploy-kafka-consumer

##################################

.PHONY: undeploy
undeploy: undeploy-kafka-consumer undeploy-rest-service undeploy-app undeploy-common undeploy-kafka

##################################

.PHONY:
login:
ifdef OC_TOKEN
	$(info **** Using OC_TOKEN for login ****)
	oc login ${OC_URL} --token=${OC_TOKEN}
else
	$(info **** Using OC_USER and OC_PASSWORD for login ****)
	oc login ${OC_URL} -u ${OC_USER} -p ${OC_PASSWORD} --insecure-skip-tls-verify=true
endif
ifdef OC_PROJECT
	$(info **** Setting project ****)
	oc project ${OC_PROJECT} 2> /dev/null || oc new-project ${OC_PROJECT}
	oc project
endif

##################################

.PHONY: deploy-kafka
deploy-kafka:
	./kafka/deploy.sh

##################################

.PHONY: undeploy-kafka
undeploy-kafka:
	./kafka/undeploy.sh

##################################

.PHONY: deploy-common
deploy-common:
	./common/deploy.sh

##################################

.PHONY: undeploy-common
undeploy-common:
	./common/undeploy.sh

##################################

.PHONY: deploy-app
deploy-app:
	./app/deploy.sh

##################################

.PHONY: undeploy-app
undeploy-app:
	./app/undeploy.sh

##################################

.PHONY: deploy-rest-service
deploy-rest-service:
	./rest-service/deploy.sh

##################################

.PHONY: undeploy-rest-service
undeploy-rest-service:
	./rest-service/undeploy.sh

##################################

.PHONY: deploy-kafka-consumer
deploy-kafka-consumer:
	./kafka-consumer/deploy.sh

##################################

.PHONY: undeploy-kafka-consumer
undeploy-kafka-consumer:
	./kafka-consumer/undeploy.sh

##################################
