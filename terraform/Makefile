#!/bin/bash -xe

include ../.env
export 

# INIT ALL

init-all:
	cd S3-Backup && make init && cd .. && \
	cd EC2-Server && make init && cd .. && \
	cd CloudWatch-Dashboard && make init && cd .. && \
	cd CloudWatch-Alarms && make init && cd .. && \
	cd Grafana-Dashboard && make init && cd ..

# PLAN COMMANDS

plan-backups:
	cd S3-Backup && make plan

plan-server:
	cd EC2-Server && make plan

plan-cw-dashboard:
	cd CloudWatch-Dashboard && make plan

plan-cw-alarms:
	cd CloudWatch-Alarms && make plan

plan-grafana:
	cd Grafana-Dashboard && make plan

# APPLY COMMANDS

apply-backups:
	cd S3-Backup && make plan && make apply

apply-server:
	cd EC2-Server && make plan && make apply

apply-cw-dashboard:
	cd CloudWatch-Dashboard && make plan && make apply

apply-cw-alarms:
	cd CloudWatch-Alarms && make plan && make apply

apply-grafana-dashboard:
	cd Grafana-Dashboard && make plan && make apply

apply-all:
	cd EC2-Server && make plan && make apply && cd .. && \
	cd CloudWatch-Dashboard && make plan && make apply && cd .. && \
	cd CloudWatch-Alarms && make plan && make apply && cd .. && sleep 150 && \
	cd Grafana-Dashboard && make plan && make apply

# DESTROY COMMANDS

destroy-all:
	cd Grafana-Dashboard && make destroy && cd .. && \
	cd CloudWatch-Alarms && make destroy && cd .. && \
	cd CloudWatch-Dashboard && make destroy && cd .. && \
	cd EC2-Server && make destroy 
