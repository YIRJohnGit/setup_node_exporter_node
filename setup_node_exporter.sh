#!/bin/bash

# Download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz

# Extract the tarball
tar xvfz node_exporter-1.2.2.linux-amd64.tar.gz

# Move the binary to /usr/local/bin
sudo mv node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin/

# Clean up
rm -rf node_exporter-1.2.2.linux-amd64.tar.gz node_exporter-1.2.2.linux-amd64

# Create a user for Node Exporter
sudo useradd -rs /bin/false node_exporter

# Create a systemd service file
cat << EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon
sudo systemctl daemon-reload

# Start and enable Node Exporter
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Check status
sudo systemctl status node_exporter
