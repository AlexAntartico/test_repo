packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

locals {
  image_name = "DevOps_Minecraft_AMI_{{timestamp}}"
}

source "amazon-ebs" "minecraft_server" {
  ami_name      = local.image_name
  instance_type = var.instance_size
  region        = var.region

  source_ami           = var.source_ami_id
  security_group_id    = "sg-0e98e45affa67ef4d"
  ssh_username         = "centos"
  ssh_keypair_name     = "${var.server_key_name}"
  ssh_private_key_file = "~/.ssh/${var.server_key_name}.pem"

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = var.volume_mount_path
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }

  tags = {
    Name = local.image_name
  }
}

build {
  sources = [
    "source.amazon-ebs.minecraft_server"
  ]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"
    ]
  }

  provisioner "ansible" {
    playbook_file          = "../ansible/playbooks/update-pkg.yml"
    extra_arguments        = ["--extra-vars", "inventory_file=../ansible/inventory_aws_ec2.yml"]
    ansible_ssh_extra_args = ["-o ServerAliveInterval=30 -o ControlMaster=auto -o ControlPersist=60s"]
    timeout                = "10m"
  }

  provisioner "shell" {
    environment_vars = [
      "MAP_BACKUP_BUCKET=lets-devops-minecraft-map-backups",
      "MINECRAFT_SERVER_URL=https://piston-data.mojang.com/v1/objects/5b868151bd02b41319f54c8d4061b8cae84e665c/server.jar",
      "JAVA_MAX_RAM=3",
      "JAVA_MIN_RAM=3",
      "ENABLE_JMX_MONITORING=false",
      "RCON_PORT=25575",
      "LEVEL_SEED=69420020036756093",
      "GAMEMODE=creative",
      "ENABLE_COMMAND_BLOCK=false",
      "ENABLE_QUERY=false",
      "GENERATOR_SETTINGS=",
      "LEVEL_NAME=linux-minecraft",
      "MOTD=A Linux-Terraform Minecraft Server",
      "QUERY_PORT=25565",
      "PVP=true",
      "GENERATE_STRUCTURES=true",
      "DIFFICULTY=easy",
      "NETWORK_COMPRESSION_THRESHOLD=256",
      "MAX_TICK_TIME=60000",
      "USE_NATIVE_TRANSPORT=true",
      "MAX_PLAYERS=8",
      "ONLINE_MODE=true",
      "ENABLE_STATUS=true",
      "ALLOW_FLIGHT=false",
      "BROADCAST_RCON_TO_OPS=true",
      "VIEW_DISTANCE=10",
      "MAX_BUILD_HIGHT=256",
      "SERVER_IP=",
      "ALLOW_NETHER=true",
      "SERVER_PORT=25565",
      "ENABLE_RCON=true",
      "SYNC_CHUNK_WRITES=true",
      "OP_PERMISSION_LEVEL=4",
      "PREVENT_PROXY_CONNECTIONS=false",
      "RESOURCE_PACK=",
      "ENTITY_BROADCAST_RANGE_PERCENTAGE=100",
      "RCON_PASSWORD=rcontest",
      "PLAYER_IDLE_TIMEOUT=900",
      "FORCE_GAMEMODE=false",
      "RATE_LIMIT=0",
      "HARDCORE=false",
      "WHITE_LIST=false",
      "BROADCAST_CONSOLE_TO_OPS=true",
      "SPAWN_NPCS=true",
      "SPAWN_ANIMALS=true",
      "SNOOPER_ENABLED=true",
      "FUNCTION_PERMISSION_LEVEL=2",
      "LEVEL_TYPE=default",
      "SPAWN_MONSTERS=true",
      "ENFORCE_WHITELIST=false",
      "RESOURCE_PACK_SHA1=",
      "SPAWN_PROTECTION=16",
      "MAX_WORLD_SIZE=5000"
    ]
    script = "scripts/user-data.sh"
  }
}