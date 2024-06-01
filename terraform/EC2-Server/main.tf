module "minecraft_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name = "Minecraft-Server"

  ami                         = var.ami_id
  associate_public_ip_address = true
  instance_type               = var.instance_size
  key_name                    = var.server_key
  monitoring                  = true

  vpc_security_group_ids = [
    aws_security_group.minecraft_security_group.id
  ]
  subnet_id = aws_default_subnet.default_az1.id

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 20
    }
  ]

  iam_instance_profile = aws_iam_instance_profile.monitoring_metrics_profile.name
  user_data            = data.template_file.restart_services.rendered # Use with Golden AMI
  # user_data            = data.template_file.user_data.rendered # Normal Bash Script Configuration

  tags = {
    Name        = "Minecraft DevOps Server"
    Game        = "Minecraft"
    Environment = "Dev"
    Stage       = "Alpha"
  }
}

data "template_file" "restart_services" {
  template = file("restart-services.sh")
}

data "template_file" "user_data" {
  template = file("user-data.sh")

  vars = {
    map_backup_bucket = "lets-devops-minecraft-map-backups"
    # URL for Minecraft Server, Version 1.20.2
    minecraft_server_url              = "https://piston-data.mojang.com/v1/objects/5b868151bd02b41319f54c8d4061b8cae84e665c/server.jar"
    java_max_ram                      = "3"
    java_min_ram                      = "3"
    enable-jmx-monitoring             = "false"
    rcon-port                         = "25575"
    level-seed                        = "69420020036756093"
    gamemode                          = "survival"
    enable-command-block              = "false"
    enable-query                      = "false"
    generator-settings                = ""
    level-name                        = "linux-minecraft"
    motd                              = "A Linux-Terraform Minecraft Server"
    query-port                        = "25565"
    pvp                               = "true"
    generate-structures               = "true"
    difficulty                        = "easy"
    network-compression-threshold     = "256"
    max-tick-time                     = "60000"
    use-native-transport              = "true"
    max-players                       = "4"
    online-mode                       = "true"
    enable-status                     = "true"
    allow-flight                      = "false"
    broadcast-rcon-to-ops             = "true"
    view-distance                     = "10"
    max-build-height                  = "256"
    server-ip                         = ""
    allow-nether                      = "true"
    server-port                       = "25565"
    enable-rcon                       = "true"
    sync-chunk-writes                 = "true"
    op-permission-level               = "4"
    prevent-proxy-connections         = "false"
    resource-pack                     = ""
    entity-broadcast-range-percentage = "100"
    rcon-password                     = "rcontest"
    player-idle-timeout               = "0"
    force-gamemode                    = "false"
    rate-limit                        = "0"
    hardcore                          = "false"
    white-list                        = "false"
    broadcast-console-to-ops          = "true"
    spawn-npcs                        = "true"
    spawn-animals                     = "true"
    snooper-enabled                   = "true"
    function-permission-level         = "2"
    level-type                        = "default"
    spawn-monsters                    = "true"
    enforce-whitelist                 = "false"
    resource-pack-sha1                = ""
    spawn-protection                  = "16"
    max-world-size                    = "5000"
  }
}
