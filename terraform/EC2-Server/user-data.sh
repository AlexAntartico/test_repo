#!/bin/bash -x

# Base OS Update & Upgrade
sudo yum update -y
sudo yum upgrade -y

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
cd /opt/minecraft

# Download Minecraft Server Jar
curl -O ${minecraft_server_url}

# Run Minecraft for the first time so it errors and generates EULA and other files needed
java -jar server.jar

# Accept Minecraft EULA
sudo sed -i "s/false/TRUE/" /opt/minecraft/eula.txt

# Edit Minecraft Server Variables
sudo sed -i "s/enable-jmx-monitoring=false/enable-jmx-monitoring=${enable-jmx-monitoring}/" /opt/minecraft/server.properties
sudo sed -i "s/rcon.port=25575/rcon.port=${rcon-port}/" /opt/minecraft/server.properties
sudo sed -i "s/level-seed=/level-seed=${level-seed}/" /opt/minecraft/server.properties
sudo sed -i "s/gamemode=survival/gamemode=${gamemode}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-command-block=false/enable-command-block=${enable-command-block}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-query=false/enable-query=${enable-query}/" /opt/minecraft/server.properties
sudo sed -i "s/generator-settings=/generator-settings=${generator-settings}/" /opt/minecraft/server.properties
sudo sed -i "s/level-name=world/level-name=${level-name}/" /opt/minecraft/server.properties
sudo sed -i "s/motd=A Minecraft Server/motd=${motd}/" /opt/minecraft/server.properties
sudo sed -i "s/query.port=25565/query.port=${query-port}/" /opt/minecraft/server.properties
sudo sed -i "s/pvp=true/pvp=${pvp}/" /opt/minecraft/server.properties
sudo sed -i "s/generate-structures=true/generate-structures=${generate-structures}/" /opt/minecraft/server.properties
sudo sed -i "s/difficulty=easy/difficulty=${difficulty}/" /opt/minecraft/server.properties
sudo sed -i "s/network-compression-threshold=256/network-compression-threshold=${network-compression-threshold}/" /opt/minecraft/server.properties
sudo sed -i "s/max-tick-time=60000/max-tick-time=${max-tick-time}/" /opt/minecraft/server.properties
sudo sed -i "s/use-native-transport=true/use-native-transport=${use-native-transport}/" /opt/minecraft/server.properties
sudo sed -i "s/max-players=20/max-players=${max-players}/" /opt/minecraft/server.properties
sudo sed -i "s/online-mode=true/online-mode=${online-mode}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-status=true/enable-status=${enable-status}/" /opt/minecraft/server.properties
sudo sed -i "s/allow-flight=false/allow-flight=${allow-flight}/" /opt/minecraft/server.properties
sudo sed -i "s/broadcast-rcon-to-ops=true/broadcast-rcon-to-ops=${broadcast-rcon-to-ops}/" /opt/minecraft/server.properties
sudo sed -i "s/view-distance=10/view-distance=${view-distance}/" /opt/minecraft/server.properties
sudo sed -i "s/max-build-height=256/max-build-height=${max-build-height}/" /opt/minecraft/server.properties
sudo sed -i "s/server-ip=/server-ip=${server-ip}/" /opt/minecraft/server.properties
sudo sed -i "s/allow-nether=true/allow-nether=${allow-nether}/" /opt/minecraft/server.properties
sudo sed -i "s/server-port=25565/server-port=${server-port}/" /opt/minecraft/server.properties
sudo sed -i "s/enable-rcon=false/enable-rcon=${enable-rcon}/" /opt/minecraft/server.properties
sudo sed -i "s/sync-chunk-writes=true/sync-chunk-writes=${sync-chunk-writes}/" /opt/minecraft/server.properties
sudo sed -i "s/op-permission-level=4/op-permission-level=${op-permission-level}/" /opt/minecraft/server.properties
sudo sed -i "s/prevent-proxy-connections=false/prevent-proxy-connections=${prevent-proxy-connections}/" /opt/minecraft/server.properties
sudo sed -i "s/resource-pack=/resource-pack=${resource-pack}/" /opt/minecraft/server.properties
sudo sed -i "s/entity-broadcast-range-percentage=100/entity-broadcast-range-percentage=${entity-broadcast-range-percentage}/" /opt/minecraft/server.properties
sudo sed -i "s/rcon.password=/rcon.password=${rcon-password}/" /opt/minecraft/server.properties
sudo sed -i "s/player-idle-timeout=0/player-idle-timeout=${player-idle-timeout}/" /opt/minecraft/server.properties
sudo sed -i "s/force-gamemode=false/force-gamemode=${force-gamemode}/" /opt/minecraft/server.properties
sudo sed -i "s/rate-limit=0/rate-limit=${rate-limit}/" /opt/minecraft/server.properties
sudo sed -i "s/hardcore=false/hardcore=${hardcore}/" /opt/minecraft/server.properties
sudo sed -i "s/white-list=false/white-list=${white-list}/" /opt/minecraft/server.properties
sudo sed -i "s/broadcast-console-to-ops=true/broadcast-console-to-ops=${broadcast-console-to-ops}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-npcs=true/spawn-npcs=${spawn-npcs}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-animals=true/spawn-animals=${spawn-animals}/" /opt/minecraft/server.properties
sudo sed -i "s/snooper-enabled=true/snooper-enabled=${snooper-enabled}/" /opt/minecraft/server.properties
sudo sed -i "s/function-permission-level=2/function-permission-level=${function-permission-level}/" /opt/minecraft/server.properties
sudo sed -i "s/level-type=default/level-type=${level-type}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-monsters=true/spawn-monsters=${spawn-monsters}/" /opt/minecraft/server.properties
sudo sed -i "s/enforce-whitelist=false/enforce-whitelist=${enforce-whitelist}/" /opt/minecraft/server.properties
sudo sed -i "s/resource-pack-sha1=/resource-pack-sha1=${resource-pack-sha1}/" /opt/minecraft/server.properties
sudo sed -i "s/spawn-protection=16/spawn-protection=${spawn-protection}/" /opt/minecraft/server.properties
sudo sed -i "s/max-world-size=29999984/max-world-size=${max-world-size}/" /opt/minecraft/server.properties

# Let Server Run in the Background a while to create other default files.
java -jar server.jar &
sleep 180
PID=`ps -C java -o pid=`
kill -9 $PID

# Final Minecraft User Permission Operations
sudo chown -R minecraft:minecraft /opt/minecraft

# Custom Systemd Service for Minecraft Server
sudo cat << "EOF" > /etc/systemd/system/minecraft.service
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
sudo sed -i "s/Xmx2G/Xmx${java_max_ram}G/" /etc/systemd/system/minecraft.service
sudo sed -i "s/Xms2G/Xms${java_min_ram}G/" /etc/systemd/system/minecraft.service

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

aws s3 cp /opt/minecraft/linux-minecraft/ s3://${map_backup_bucket}/linux-minecraft/$date --recursive

# Delete Latest to save new copy
aws s3 rm s3://${map_backup_bucket}/linux-minecraft/latest --recursive

# Copy Current to Latest
aws s3 cp /opt/minecraft/linux-minecraft/ s3://${map_backup_bucket}/linux-minecraft/latest --recursive
EOF

sudo cat << "EOF" > /home/centos/recover.sh
#!/bin/bash -xe

# Stop Server to edit map files
sudo systemctl stop minecraft

sudo rm -rf /opt/minecraft/linux-minecraft

# Recover from Latest to Server
aws s3 cp s3://${map_backup_bucket}/linux-minecraft/latest ~/linux-minecraft --recursive 
sudo mv ~/linux-minecraft /opt/minecraft/linux-minecraft

# Change Directory Permissions
sudo chown -R minecraft:minecraft /opt/minecraft

# Start Server Loading the Recovered map
sudo systemctl start minecraft
EOF

sudo chmod +x /home/centos/backup.sh
sudo chmod +x /home/centos/recover.sh

# Install AWS CLI for Backup functionality
cd /home/centos/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# Optional Recover Server From Previous Save
cd /home/centos/
# ./recover.sh

# Download and extract Prometheus
wget -O - https://github.com/prometheus/prometheus/releases/download/v2.47.2/prometheus-2.47.2.linux-amd64.tar.gz | tar -xzv --transform 's:^[^/]*:prometheus-files:'

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
tee /etc/systemd/system/prometheus.service << EOF
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
systemctl enable prometheus
systemctl start prometheus
systemctl status prometheus

# Download and extract the Node Exporter
wget -O - https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz | tar -xzv --transform 's:^[^/]*:node_exporter:'

# Create a node_exporter user to run the node exporter service.
sudo useradd -rs /bin/false node_exporter

# Change permissions for the node_exporter
sudo chown -R node_exporter:node_exporter node_exporter

# Move the node export binary to /usr/local/bin
sudo mv node_exporter /usr/local/bin/

# Create a Node Exporter Service File and save it
tee /etc/systemd/system/node_exporter.service << EOF
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
systemctl enable node_exporter
systemctl start node_exporter
systemctl status node_exporter

# Install Minecraft Prometheus Exporter and Start/Enable Service 
export MINECRAFT_EXPORTER_VERSION=0.19.0
curl -sSL https://github.com/dirien/minecraft-prometheus-exporter/releases/download/v$MINECRAFT_EXPORTER_VERSION/minecraft-exporter_$MINECRAFT_EXPORTER_VERSION.linux-amd64.tar.gz | tar -xz  

sudo useradd minecraft_exporter
cp minecraft-exporter /usr/local/bin
chown minecraft_exporter:minecraft_exporter /usr/local/bin/minecraft-exporter

# Configure Minecraft Prometheus Exporter Service
tee /etc/systemd/system/minecraft-exporter.service <<EOF
[Unit]
Description=Minecraft Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=minecraft_exporter
Group=minecraft_exporter
Type=simple
ExecStart=/usr/local/bin/minecraft-exporter \
  --mc.rcon-password=rcontest \
  --mc.world=/opt/minecraft/linux-minecraft \
  --web.disable-exporter-metrics
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
systemctl start minecraft-exporter.service
systemctl enable minecraft-exporter.service
systemctl status minecraft-exporter.service

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
wget -O grafana-enterprise-10.rpm https://dl.grafana.com/enterprise/release/grafana-enterprise-10.1.5-1.x86_64.rpm
sudo yum install grafana-enterprise-10.rpm -y

sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server