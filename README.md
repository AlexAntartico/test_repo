# Lets DevOps Minecraft

## Tools and Versions

- Terraform `v1.5.5`
- Packer `v1.9.2`
- Ansible `v.2.13.13`
- Yamllint `v1.32.0`

## Prerequisites

- AWS CLI properly configured, with enough permissions, etc.
- Creating a Remote State S3 Bucket and DynamoDB Table for Terraform Locks.
- Creating a Map Backups S3 Bucket (deploy using `terraform/S3-Backup`)
- Having a valid domain name registered in Route53.
- Subscribing to Marketplace AMI we are using as base in order to use it in Terraform + Packer. (Centos 8)
- Exiting the SNS/SMS Sandbox by opening an AWS Case, instructions for this are provided in the AWS Console or Using Limited Sandbox Approved SMS Numbers.
- Creating an SSH Key in AWS in `us-east-1` to use for Packer or Terraform, we are calling it `minecraft-server-key` as an example. Replace any ocurrences of this name with your key name `ansible/` might have 1 instance of this key name hardcoded.
- Creating an `.env` environment variable file in the root of the repo and filling it with the required values, example:

```bash
# Global Terraform Variables

REMOTE_BUCKET_NAME=
REMOTE_DYNAMODB_TABLE=
AWS_DEFAULT_REGION=us-east-1

# S3-Backup Terraform Variables
BACKUP_BUCKET_NAME=

# EC2-Server Terraform Variables
SERVER_DOMAIN_NAME=
SERVER_SUBDOMAIN_NAME=
SMS_NUMBERS=["", ""]

# Packer SSH Key Name
PACKER_SSH_KEY=

# Grafana Variables
GRAFANA_AUTH=admin:admin
GRAFANA_DOMAIN=http://minecraft.armandoherra.games:3000/
```

## Getting Started

- Once you have configured all the pre-requisites, you can adjust the server settings, level name, etc to your liking in the Packer configuration (`packer/`), and once that is ready, run: `make init` and `make build` in `packer/` to create the AWS AMI image, wait until build finishes and you see a message similar to this:

```bash
==> amazon-ebs.minecraft_server: Stopping the source instance...
    amazon-ebs.minecraft_server: Stopping instance
==> amazon-ebs.minecraft_server: Waiting for the instance to stop...
==> amazon-ebs.minecraft_server: Creating AMI DevOps_Minecraft_AMI_1699515587 from instance i-0535a8d6bc5c28d5a
    amazon-ebs.minecraft_server: AMI: ami-084272c54c560ab80
==> amazon-ebs.minecraft_server: Waiting for AMI to become ready...
==> amazon-ebs.minecraft_server: Skipping Enable AMI deprecation...
==> amazon-ebs.minecraft_server: Adding tags to AMI (ami-084272c54c560ab80)...
==> amazon-ebs.minecraft_server: Tagging snapshot: snap-02525dc9fcf4cd97b
==> amazon-ebs.minecraft_server: Creating AMI tags
    amazon-ebs.minecraft_server: Adding tag: "Name": "DevOps_Minecraft_AMI_1699515587"
==> amazon-ebs.minecraft_server: Creating snapshot tags
==> amazon-ebs.minecraft_server: Terminating the source AWS instance...
==> amazon-ebs.minecraft_server: Cleaning up any extra volumes...
==> amazon-ebs.minecraft_server: No volumes to clean up, skipping
Build 'amazon-ebs.minecraft_server' finished after 18 minutes 34 seconds.

==> Wait completed after 18 minutes 34 seconds

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs.minecraft_server: AMIs were created:
us-east-1: ami-084272c54c560ab80
```

- Copy the AMI ID you obtain for your server and replace the value in `terraform/EC2-Server/variables.tf` specifically for the variable named `ami_id`.
- Create the Backups S3 Bucket before any other infrastructure, this will also let you know if you are correctly configured and set to deploy the rest of the infrastructure. Run `make init-all` and `make apply-backups` in the `terraform/` directory.
- Once that is done you can attempt to deploy the resources and the server, do so by going to the `terraform/` directory and running `make apply-all`.
- If all is successful you should have a running server in 2-3 minutes!
- When done using the server just run `make destroy-all`
- If you want to make use of the backups/restores, you need to SSH into the MC Server VM and run the scripts from the root directory `./backup` or `./recover`.
