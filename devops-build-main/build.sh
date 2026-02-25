#!/bin/bash

ENVIRONMENT=$1
TAG=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$TAG" ]; then
  echo "Usage: ./build.sh <dev|prod> <tag>"
  exit 1
fi

DOCKER_USERNAME="dinesh0793"

LOCAL_IMAGE="react-app:$TAG"
REMOTE_IMAGE="$DOCKER_USERNAME/$ENVIRONMENT:$TAG"

echo "Building image..."
docker build -t $LOCAL_IMAGE .

if [ $? -ne 0 ]; then
  echo "Build failed."
  exit 1
fi

echo "Tagging image..."
docker tag $LOCAL_IMAGE $REMOTE_IMAGE

echo "Pushing image to Docker Hub..."
docker push $REMOTE_IMAGE

if [ $? -eq 0 ]; then
  echo "Image pushed successfully."
else
  echo "Push failed."
  exit 1
fi
