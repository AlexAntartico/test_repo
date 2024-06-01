#!/bin/bash -x

include ../../.env
export 

###

lint: 
	terraform fmt -recursive && terraform validate

clean:
	rm -rf .terraform && rm tfplan

init: 
	terraform init -input=false \
	-backend-config="bucket=${REMOTE_BUCKET_NAME}" \
	-backend-config="dynamodb_table=${REMOTE_DYNAMODB_TABLE}" && \
	export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

refresh:
	make lint && \
	terraform refresh \
	-var "grafana_auth=${GRAFANA_AUTH}" \
	-var "grafana_domain=${GRAFANA_DOMAIN}" \
	-input=false

plan: 
	make lint && \
	terraform plan \
	-var "grafana_auth=${GRAFANA_AUTH}" \
	-var "grafana_domain=${GRAFANA_DOMAIN}" \
	-input=false \
	-out=tfplan

apply:
	terraform apply -input=false tfplan

destroy:
	make lint && \
	terraform destroy \
	-var "grafana_auth=${GRAFANA_AUTH}" \
	-var "grafana_domain=${GRAFANA_DOMAIN}" \
	-auto-approve \
	-state=tfplan