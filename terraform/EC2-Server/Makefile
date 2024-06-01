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
	-var "remote_state_bucket=${REMOTE_BUCKET_NAME}" \
	-var "server_domain_name=${SERVER_DOMAIN_NAME}" \
	-var "server_subdomain_name=${SERVER_SUBDOMAIN_NAME}" \
	-input=false

plan: 
	make lint && \
	./create-key-pair.sh && \
	terraform plan \
	-var "remote_state_bucket=${REMOTE_BUCKET_NAME}" \
	-var "server_domain_name=${SERVER_DOMAIN_NAME}" \
	-var "server_subdomain_name=${SERVER_SUBDOMAIN_NAME}" \
	-input=false \
	-out=tfplan

apply:
	terraform apply -input=false tfplan

destroy:
	make lint && \
	terraform destroy \
	-var "remote_state_bucket=${REMOTE_BUCKET_NAME}" \
	-var "server_domain_name=${SERVER_DOMAIN_NAME}" \
	-var "server_subdomain_name=${SERVER_SUBDOMAIN_NAME}" \
	-auto-approve \
	-state=tfplan