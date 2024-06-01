#!/bin/bash -x

include ../.env
export 

init:
	packer init .

fmt:
	packer fmt -recursive .

validate:
	packer validate -var "server_key_name=${PACKER_SSH_KEY}" .

build:
	make fmt && \
	make validate && \
	packer build -var "server_key_name=${PACKER_SSH_KEY}" .