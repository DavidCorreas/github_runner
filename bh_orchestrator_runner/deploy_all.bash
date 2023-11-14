#!/bin/bash

# eval $(minikube docker-env)

# Create the secret for the github token
kubectl apply -f github-secret.yaml

# Build the image. This generates image=github-runner-orchestrator
cp -r /home/david/.minikube/certs ./certs
docker compose build # No minikube env. Need to copy files from host
minikube image load github-runner-orchestrator

# Deploy the orchestrator
kubectl apply -f runner-manifest.yaml
