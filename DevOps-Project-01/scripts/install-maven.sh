#!/bin/bash
sudo yum install git -y
sudo yum install java-11-openjdk-devel -y
wget https://mirrors.ocf.berkeley.edu/apache/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
sudo tar -xvzf apache-maven-3.8.4-bin.tar.gz -C /opt/
sudo ln -s /opt/apache-maven-3.8.4 /opt/maven

echo "export M2_HOME=/opt/maven" | sudo tee -a /etc/profile.d/maven.sh
echo "export PATH=\$M2_HOME/bin:\$PATH" | sudo tee -a /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

mvn -version