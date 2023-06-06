#!/bin/bash
# NOTE: Below steps supports only for MacOS

# set -x

# Download binaries to some temp location
mkdir -p /tmp/k8s-install
cd /tmp/k8s-install

# Install Docker 
curl -LO https://desktop.docker.com/mac/main/amd64/Docker.dmg
sudo hdiutil attach Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
sudo hdiutil detach /Volumes/Docker

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Display version
kubectl version --client

# Install minikube as local K8s cluster
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube

# Start minikube
minikube start

# Verify Minikube status
minikube status

# Get namespace to verify the access
kubectl get ns