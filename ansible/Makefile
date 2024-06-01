#!/bin/bash

lint:
	yamllint playbooks/

inventory:
	ansible-inventory -i inventory_aws_ec2.yml --list

ping:
	make inventory && \
	ansible-playbook playbooks/ping.yml -v

update:
	make inventory && \
	ansible-playbook playbooks/update-pkg.yml -vv