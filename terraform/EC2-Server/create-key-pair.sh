#!/bin/bash -xe

keypair_exists=$(aws ec2 describe-key-pairs \
    | grep "minecraft-server-key" \
    | cut -d "\"" -f 4)

if [[ $keypair_exists == "minecraft-server-key" ]]; then
    echo "Keypair found, nothing to do, exiting..."
    exit 0
else
    echo -e "No Keypair Found, generating one..."
    aws ec2 create-key-pair --key-name minecraft-server-key --query 'KeyMaterial' --output text > minecraft-server-key.pem
    chmod 400 minecraft-server-key.pem
    sudo mv minecraft-server-key.pem ~/.ssh
fi
