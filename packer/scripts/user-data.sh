#!/bin/bash -x

# # Base OS Update & Upgrade
# sudo yum update -y
# sudo yum upgrade -y

# Debug & Editing Utilities
sudo yum install vim wget unzip -y

# CloudWatch Custom Metrics prerequisites
wget https://s3.us-east-1.amazonaws.com/amazoncloudwatch-agent-us-east-1/centos/amd64/latest/amazon-cloudwatch-agent.rpm 
wget https://s3.us-east-1.amazonaws.com/amazoncloudwatch-agent-us-east-1/centos/amd64/latest/amazon-cloudwatch-agent.rpm.sig
wget https://s3.amazonaws.com/amazoncloudwatch-agent/assets/amazon-cloudwatch-agent.gpg
gpg --verify amazon-cloudwatch-agent.rpm.sig amazon-cloudwatch-agent.rpm
gpg --import amazon-cloudwatch-agent.gpg
gpg --fingerprint 3B789C72

# Install CloudWatch Agent
sudo rpm -U ./amazon-cloudwatch-agent.rpm

# Download CloudWatch Agent Config
curl -O https://gist.githubusercontent.com/ArmandoHerra/582599e50e9ad9a669d681954f52bd8d/raw/852d24cec8fe81b2bafa82c8ab16f4f4f30ac11b/amazon-cloudwatch-agent.json
sudo mv amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Turn CloudWatch Agent On
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status

# Minecraft Server prerequisites
sudo yum install java-17-openjdk -y
java --version

# Minecraft User Permission Operations
sudo useradd minecraft
cd /
sudo mkdir /opt/minecraft
sudo chown -R minecraft:minecraft /opt/minecraft

# Download Minecraft Server Jar
sudo curl -O ${MINECRAFT_SERVER_URL}
sudo mv server.jar /opt/minecraft

cd /opt/minecraft

# Run Minecraft for the first time so it errors and generates EULA and other files needed
sudo java -jar server.jar

# Accept Minecraft EULA
sudo sed -i "s/false/TRUE/" /opt/minecraft/eula.txt

# Edit Minecraft Server Variables
sudo sed -i "s/enable-jmx-monitoring=false/enable-jmx-monitoring=${ENABLE_JMX_MONITORING}/" /opt/minecraft/server.properties
sudo sed -i "s/rcon.port=25575/rcon.port=${RCON_PORT}/" /opt/minecraft/server.properties
sudo sed -i "s/level-seed=/level-seed=${LEVEL_SEED}/" /opt/minecraft/server.properties
sudo sed -i "s/gamemode=survival/gamemode=${GAMEMODE}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-command-block=false/enable-command-block=${ENABLE_COMMAND_BLOCK}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-query=false/enable-query=${ENABLE_QUERY}/" /opt/minecraft/server.properties
sudo sed -i "s/generator-settings=/generator-settings=${GENERATOR_SETTINGS}/" /opt/minecraft/server.properties
sudo sed -i "s/level-name=world/level-name=${LEVEL_NAME}/" /opt/minecraft/server.properties
sudo sed -i "s/motd=A Minecraft Server/motd=${MOTD}/" /opt/minecraft/server.properties
sudo sed -i "s/query.port=25565/query.port=${QUERY_PORT}/" /opt/minecraft/server.properties
sudo sed -i "s/pvp=true/pvp=${PVP}/" /opt/minecraft/server.properties
sudo sed -i "s/generate-structures=true/generate-structures=${GENERATE_STRUCTURES}/" /opt/minecraft/server.properties
sudo sed -i "s/difficulty=easy/difficulty=${DIFFICULTY}/" /opt/minecraft/server.properties
sudo sed -i "s/network-compression-threshold=256/network-compression-threshold=${NETWORK_COMPRESSION_THRESHOLD}/" /opt/minecraft/server.properties
sudo sed -i "s/max-tick-time=60000/max-tick-time=${MAX_TICK_TIME}/" /opt/minecraft/server.properties
sudo sed -i "s/use-native-transport=true/use-native-transport=${USE_NATIVE_TRANSPORT}/" /opt/minecraft/server.properties
sudo sed -i "s/max-players=20/max-players=${MAX_PLAYERS}/" /opt/minecraft/server.properties
sudo sed -i "s/online-mode=true/online-mode=${ONLINE_MODE}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-status=true/enable-status=${ENABLE_STATUS}/" /opt/minecraft/server.properties
sudo sed -i "s/allow-flight=false/allow-flight=${ALLOW_FLIGHT}/" /opt/minecraft/server.properties
sudo sed -i "s/broadcast-rcon-to-ops=true/broadcast-rcon-to-ops=${BROADCAST_RCON_TO_OPS}/" /opt/minecraft/server.properties
sudo sed -i "s/view-distance=10/view-distance=${VIEW_DISTANCE}/" /opt/minecraft/server.properties
sudo sed -i "s/max-build-height=256/max-build-height=${MAX_BUILD_HIGHT}/" /opt/minecraft/server.properties
sudo sed -i "s/server-ip=/server-ip=${SERVER_IP}/" /opt/minecraft/server.properties
sudo sed -i "s/allow-nether=true/allow-nether=${ALLOW_NETHER}/" /opt/minecraft/server.properties
sudo sed -i "s/server-port=25565/server-port=${SERVER_PORT}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-rcon=false/enable-rcon=${ENABLE_RCON}/" /opt/minecraft/server.properties
sudo sed -i "s/sync-chunk-writes=true/sync-chunk-writes=${SYNC_CHUNK_WRITES}/" /opt/minecraft/server.properties
sudo sed -i "s/op-permission-level=4/op-permission-level=${OP_PERMISSION_LEVEL}/" /opt/minecraft/server.properties
sudo sed -i "s/prevent-proxy-connections=false/prevent-proxy-connections=${PREVENT_PROXY_CONNECTIONS}/" /opt/minecraft/server.properties
sudo sed -i "s/resource-pack=/resource-pack=${RESOURCE_PACK}/" /opt/minecraft/server.properties
sudo sed -i "s/entity-broadcast-range-percentage=100/entity-broadcast-range-percentage=${ENTITY_BROADCAST_RANGE_PERCENTAGE}/" /opt/minecraft/server.properties
sudo sed -i "s/rcon.password=/rcon.password=${RCON_PASSWORD}/" /opt/minecraft/server.properties
sudo sed -i "s/player-idle-timeout=0/player-idle-timeout=${PLAYER_IDLE_TIMEOUT}/" /opt/minecraft/server.properties
sudo sed -i "s/force-gamemode=false/force-gamemode=${FORCE_GAMEMODE}/" /opt/minecraft/server.properties
sudo sed -i "s/rate-limit=0/rate-limit=${RATE_LIMIT}/" /opt/minecraft/server.properties
sudo sed -i "s/hardcore=false/hardcore=${HARDCORE}/" /opt/minecraft/server.properties
sudo sed -i "s/white-list=false/white-list=${WHITE_LIST}/" /opt/minecraft/server.properties
sudo sed -i "s/broadcast-console-to-ops=true/broadcast-console-to-ops=${BROADCAST_CONSOLE_TO_OPS}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-npcs=true/spawn-npcs=${SPAWN_NPCS}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-animals=true/spawn-animals=${SPAWN_ANIMALS}/" /opt/minecraft/server.properties
sudo sed -i "s/snooper-enabled=true/snooper-enabled=${SNOOPER_ENABLED}/" /opt/minecraft/server.properties
sudo sed -i "s/function-permission-level=2/function-permission-level=${FUNCTION_PERMISSION_LEVEL}/" /opt/minecraft/server.properties
sudo sed -i "s/level-type=default/level-type=${LEVEL_TYPE}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-monsters=true/spawn-monsters=${SPAWN_MONSTERS}/" /opt/minecraft/server.properties
sudo sed -i "s/enforce-whitelist=false/enforce-whitelist=${ENFORCE_WHITELIST}/" /opt/minecraft/server.properties
sudo sed -i "s/resource-pack-sha1=/resource-pack-sha1=${RESOURCE_PACK_SHA1}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-protection=16/spawn-protection=${SPAWN_PROTECTION}/" /opt/minecraft/server.properties
sudo sed -i "s/max-world-size=29999984/max-world-size=${MAX_WORLD_SIZE}/" /opt/minecraft/server.properties

# Let Server Run in the Background a while to create other default files.
sudo java -jar server.jar &
sleep 180
PID=`ps -C java -o pid=`
sudo kill -9 $PID

# Final Minecraft User Permission Operations
sudo chown -R minecraft:minecraft /opt/minecraft

# Custom Systemd Service for Minecraft Server
sudo tee /etc/systemd/system/minecraft.service << EOF
[Unit]
Description=Vanilla Minecraft Java Edition Server
After=network.target

[Service]
User=minecraft
WorkingDirectory=/opt/minecraft
ExecStart=/bin/sh -c '/bin/java -Xmx2G -Xms2G -jar server.jar >> /tmp/minecraft.log 2>&1'
Restart=on-failure
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF

# Edit Java Max & Min RAM Flags
sudo sed -i "s/Xmx2G/Xmx${JAVA_MAX_RAM}G/" /etc/systemd/system/minecraft.service
sudo sed -i "s/Xms2G/Xms${JAVA_MIN_RAM}G/" /etc/systemd/system/minecraft.service

# Reload systemctl daemon & Start Minecraft service
sudo systemctl daemon-reload
sudo systemctl enable minecraft
sudo systemctl start minecraft

# Backup utilities
sudo cat << "EOF" > /home/centos/backup.sh
#!/bin/bash -xe

date=$(date +"%Y-%m-%d-%T")

# Stop Server to backup map
sudo systemctl stop minecraft

aws s3 cp /opt/minecraft/linux-minecraft/ s3://MAP_BACKUP_BUCKET/linux-minecraft/$date --recursive

# Delete Latest to save new copy
aws s3 rm s3://MAP_BACKUP_BUCKET/linux-minecraft/latest --recursive

# Copy Current to Latest
aws s3 cp /opt/minecraft/linux-minecraft/ s3://MAP_BACKUP_BUCKET/linux-minecraft/latest --recursive

# Start Server After Backup
sudo systemctl start minecraft
EOF

sudo cat << "EOF" > /home/centos/recover.sh
#!/bin/bash -xe

# Stop Server to edit map files
sudo systemctl stop minecraft

sudo rm -rf /opt/minecraft/linux-minecraft

# Recover from Latest to Server
aws s3 cp s3://MAP_BACKUP_BUCKET/linux-minecraft/latest ~/linux-minecraft --recursive 
sudo mv ~/linux-minecraft /opt/minecraft/linux-minecraft

# Change Directory Permissions
sudo chown -R minecraft:minecraft /opt/minecraft

# Start Server Loading the Recovered map
sudo systemctl start minecraft
EOF

sudo sed -i "s/MAP_BACKUP_BUCKET/${MAP_BACKUP_BUCKET}/" /home/centos/backup.sh
sudo sed -i "s/MAP_BACKUP_BUCKET/${MAP_BACKUP_BUCKET}/" /home/centos/recover.sh

sudo chmod +x /home/centos/backup.sh
sudo chmod +x /home/centos/recover.sh

# Install AWS CLI for Backup functionality
cd /home/centos/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
unzip awscliv2.zip >/dev/null
sudo ./aws/install
aws --version

# Optional Recover Server From Previous Save
cd /home/centos/
# ./recover.sh

# Download and extract Prometheus
wget -O - https://github.com/prometheus/prometheus/releases/download/v2.47.2/prometheus-2.47.2.linux-amd64.tar.gz | tar -xzv --transform 's:^[^/]*:prometheus-files:' >/dev/null

# Create a Prometheus user, required directories, and make Prometheus the user as the owner of those directories
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# Copy prometheus and promtool binary from prometheus-files folder to /usr/local/bin and change the ownership to prometheus user
sudo cp prometheus-files/prometheus /usr/local/bin/
sudo cp prometheus-files/promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

# Move the consoles and console_libraries directories from prometheus-files to /etc/prometheus folder and change the ownership to prometheus user
sudo cp -r prometheus-files/consoles /etc/prometheus
sudo cp -r prometheus-files/console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

sudo cat << "EOF" > prometheus.yml
global:
  scrape_interval: 10s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
EOF

sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

# RUN IN SUDO
# Systemd service for running Prometheus in the background
sudo tee /etc/systemd/system/prometheus.service << EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus

# Download and extract the Node Exporter
wget -O - https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz | tar -xzv --transform 's:^[^/]*:node_exporter:' >/dev/null

sudo useradd -rs /bin/false node_exporter
sudo chown -R node_exporter:node_exporter node_exporter
sudo mv node_exporter /usr/local/bin/

# Create a Node Exporter Service File and save it
sudo tee /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/bin/sh -c '/usr/local/bin/node_exporter/node_exporter'

[Install]
WantedBy=multi-user.target
EOF

# Reload the system daemon
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter

# Install Minecraft Prometheus Exporter and Start/Enable Service 
export MINECRAFT_EXPORTER_VERSION=0.19.0
curl -sSL https://github.com/dirien/minecraft-prometheus-exporter/releases/download/v$MINECRAFT_EXPORTER_VERSION/minecraft-exporter_$MINECRAFT_EXPORTER_VERSION.linux-amd64.tar.gz | tar -xz >/dev/null

sudo useradd minecraft_exporter
sudo cp minecraft-exporter /usr/local/bin
sudo chown minecraft_exporter:minecraft_exporter /usr/local/bin/minecraft-exporter

# Configure Minecraft Prometheus Exporter Service
sudo tee /etc/systemd/system/minecraft-exporter.service <<EOF
[Unit]
Description=Minecraft Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=minecraft_exporter
Group=minecraft_exporter
Type=simple
ExecStart=/usr/local/bin/minecraft-exporter \
  --mc.rcon-password=rconadminpass \
  --mc.world=/opt/minecraft/linux-minecraft \
  --web.disable-exporter-metrics
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start minecraft-exporter.service
sudo systemctl enable minecraft-exporter.service
sudo systemctl status minecraft-exporter.service

# Configure the Server as Target on Prometheus Server
sudo cat << "EOF" > prometheus.yml
global:
  scrape_interval: 10s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100']
  - job_name: 'mc_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9150']
EOF

sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

# Restart the Prometheus Service
sudo systemctl restart prometheus

# Install and activate grafana-server service
wget -O grafana-enterprise-10.rpm https://dl.grafana.com/enterprise/release/grafana-enterprise-10.1.5-1.x86_64.rpm >/dev/null
sudo yum install grafana-enterprise-10.rpm -y

sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server