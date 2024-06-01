#!/bin/bash -xe

keypair_exists=$(aws ec2 describe-key-pairs \
    | grep "minecraft-server-key" \
    | cut -d "\"" -f 4)

if [[ $keypair_exists == "minecraft-server-key" ]]; then
    echo "Keypair found, continuing..."
    aws ec2 delete-key-pair --key-name minecraft-server-key

else
    echo -e "No Keypair Found, nothing to do, exiting..."
    exit 0
fi
