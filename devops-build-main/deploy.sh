#!/bin/bash

IMAGE_NAME=$1
TAG=$2

if [ -z "$IMAGE_NAME" ] || [ -z "$TAG" ]; then
  echo "Usage: ./deploy.sh <image-name> <tag>"
  exit 1
fi

echo "Stopping existing container if running..."
docker stop react-app-container 2>/dev/null
docker rm react-app-container 2>/dev/null

echo "Running new container..."
docker run -d \
  --name react-app-container \
  -p 80:80 \
  --restart always \
  $IMAGE_NAME:$TAG

if [ $? -eq 0 ]; then
  echo "Deployment successful."
else
  echo "Deployment failed."
  exit 1
fi
