#!/bin/bash

# Update package index
sudo yum update -y

echo 'y' | sudo yum install wget

yum search java | grep openjdk | sudo yum install 

# Install Java
echo 'y' | sudo dnf install java-17-amazon-corretto -y

# Add Jenkins repository
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Download the Jenkins repository configuration file
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Install Jenkins with GPG key check disabled
sudo yum install jenkins -y --nogpgcheck

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins service to start on boot
sudo systemctl enable jenkins
