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

plan: 
	make lint && \
	terraform plan -var "backup_bucket_name=${BACKUP_BUCKET_NAME}" \
	-input=false \
	-out=tfplan

apply:
	terraform apply -input=false tfplan

destroy:
	make lint && \
	terraform destroy -var "backup_bucket_name=${BACKUP_BUCKET_NAME}" \
	-state=tfplan