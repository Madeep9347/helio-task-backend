#!/bin/bash
set -e

CONTAINER_NAME=backend

echo "Stopping backend container..."

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true
