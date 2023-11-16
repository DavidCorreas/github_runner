#!/bin/bash

# eval $(minikube docker-env)

# Create the secret for the github token
kubectl apply -f github-secret.yaml

# Build the image. This generates image=github-runner-kitdigital
# cp -r /home/david/.minikube/certs ./certs
docker compose build # No minikube env. Need to copy files from host
echo "Loading image into minikube"
minikube image load github-runner-kitdigital

# Deploy the runner
echo "Deploying runner"
kubectl apply -f runner-manifest.yaml
