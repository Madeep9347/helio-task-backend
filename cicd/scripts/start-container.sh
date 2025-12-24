#!/bin/bash
set -e

AWS_REGION=ap-south-1
CONTAINER_NAME=backend

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE_URI=$(cat imagedef-backend.json | jq -r '.[0].imageUri')

echo "Starting backend container with image: $IMAGE_URI"

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

aws ecr get-login-password --region $AWS_REGION | \
docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker pull $IMAGE_URI

docker run -d \
  --name $CONTAINER_NAME \
  -p 5000:5000 \
  $IMAGE_URI
