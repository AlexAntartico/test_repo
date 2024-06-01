#!/bin/bash -x

sudo systemctl restart node_exporter
sudo systemctl restart minecraft-exporter.service
sudo systemctl restart prometheus
sudo systemctl restart grafana-server
