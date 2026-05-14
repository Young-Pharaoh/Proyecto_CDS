#!/bin/bash
# Update and upgrade package lists
apt-get update -y
apt-get upgrade -y

# Install Git
apt-get install git -y

# Install Docker
apt-get install docker.io -y

# Start and enable the Docker service to run on boot
systemctl start docker
systemctl enable docker

# Install Docker Compose (V2 plugin)
apt-get install docker-compose-v2 -y

# Add the default 'ubuntu' user to the docker group
usermod -aG docker ubuntu

# Clone the repository and start the application
cd /home/ubuntu
git clone https://github.com/Young-Pharaoh/Proyecto_CDS.git proyecto_cds
chown -R ubuntu:ubuntu proyecto_cds
cd proyecto_cds
docker compose up -d --build