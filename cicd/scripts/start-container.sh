#!/bin/bash
set -e

AWS_REGION=ap-south-1
CONTAINER_NAME=backend

echo "Loading image URI..."
source image.env

echo "Starting backend container with image: $IMAGE_URI"

# Stop old container if exists
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Login to ECR
aws ecr get-login-password --region $AWS_REGION | \
docker login --username AWS --password-stdin "${IMAGE_URI%%/*}"

# Pull and run new image
docker pull $IMAGE_URI

docker run -d \
  --name $CONTAINER_NAME \
  -p 5000:5000 \
  $IMAGE_URI
