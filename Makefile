DEFAULT_ENV_FILE := .env.default
ifneq ("$(wildcard $(DEFAULT_ENV_FILE))","")
include ${DEFAULT_ENV_FILE}
export $(shell sed 's/=.*//' ${DEFAULT_ENV_FILE})
endif

ENV_FILE := .env
ifneq ("$(wildcard $(ENV_FILE))","")
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
endif



##################################

.PHONY: login
login:
ifdef OC_TOKEN
	$(info **** Using OC_TOKEN for login ****)
	oc login ${OC_URL} --token=${OC_TOKEN}
else
	$(info **** Using OC_USER and OC_PASSWORD for login ****)
	oc login ${OC_URL} -u ${OC_USER} -p ${OC_PASSWORD} --insecure-skip-tls-verify=true
endif

##################################

.PHONY: deploy-kafka
deploy-kafka: login
	./kafka/deploy.sh

##################################

.PHONY: undeploy-kafka
undeploy-kafka: login
	./kafka/undeploy.sh

##################################

.PHONY: deploy-common
deploy-common: login
	./common/deploy.sh

##################################

.PHONY: undeploy-common
undeploy-common: login
	./common/undeploy.sh

##################################

.PHONY: deploy-app
deploy-app: login
	./app/deploy.sh

##################################

.PHONY: undeploy-app
undeploy-app: login
	./app/undeploy.sh

##################################

.PHONY: deploy-rest-service
deploy-rest-service: login
	./rest-service/deploy.sh

##################################

.PHONY: undeploy-rest-service
undeploy-rest-service: login
	./rest-service/undeploy.sh

##################################

.PHONY: deploy-kafka-consumer
deploy-kafka-consumer: login
	./kafka-consumer/deploy.sh

##################################

.PHONY: undeploy-kafka-consumer
undeploy-kafka-consumer: login
	./kafka-consumer/undeploy.sh

##################################

.PHONY: deploy
deploy: login deploy-prereqs deploy-app deploy-rest-service deploy-kafka-consumer

##################################

.PHONY: undeploy
deploy: login undeploy-kafka-consumer undeploy-rest-service undeploy-app undeploy-prereqs

##################################
