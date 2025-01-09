#!/bin/bash

# Update the system
sudo yum update -y

# Install Java 11 (required for Tomcat)
echo "Installing Java 11..."
sudo yum install -y java-11-openjdk-devel

# Download and extract Apache Tomcat
TOMCAT_VERSION="9.0.53"
TOMCAT_URL="https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
echo "Downloading Apache Tomcat version ${TOMCAT_VERSION}..."
wget ${TOMCAT_URL} -O apache-tomcat.tar.gz

echo "Extracting Tomcat..."
sudo tar -xvzf apache-tomcat.tar.gz -C /opt/
sudo ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

# Set permissions
echo "Setting permissions for Tomcat..."
sudo groupadd tomcat
sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
sudo chown -R tomcat:tomcat /opt/apache-tomcat-${TOMCAT_VERSION}
sudo chmod -R 755 /opt/apache-tomcat-${TOMCAT_VERSION}

# Start Tomcat
echo "Starting Tomcat..."
sudo sh /opt/tomcat/bin/startup.sh

# Create systemd service file for Tomcat
echo "Configuring Tomcat as a systemd service..."
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, start, and enable Tomcat service
echo "Reloading systemd, starting, and enabling Tomcat service..."
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

# Verify Tomcat status
echo "Checking Tomcat status..."
sudo systemctl status tomcat --no-pager

echo "Tomcat installation and setup complete!"