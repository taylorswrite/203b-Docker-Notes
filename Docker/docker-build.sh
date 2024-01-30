#!/bin/sh

# login to docker from terminal before running the script.
# docker login -u "username" -p "password"

# Ask user for information in terminal.
read -p "Enter your dockerhub username: " username
read -p "Enter your dockerhub project name: " project
read -p "Enter a version number for the image: " version

# Use buildx to build images for different platforms (amd64 and arm64).
# An if check to make sure the version number is a version number.
if [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  # Build the amd64 image.
  docker login && docker buildx build --platform linux/amd64 \
  -f Dockerfile.amd64 -t $username/$project:v$version-amd64 \
  . --push || { echo "AMD64 build failed"; exit 1; }

  # Build the arm64 image.
  docker login && docker buildx build --platform linux/arm64 \
  -f Dockerfile.arm64 -t $username/$project:v$version-arm64 \
  . --push || { echo "ARM64 build failed"; exit 1; }

else
  echo "The version must be in the format X.Y.Z, where X, Y, and Z are numbers."
  exit 1
fi

# Create a manifest (package the platform images) to push to Docker Hub.
docker login && docker manifest create $username/$project:v$version \
$username/$project:v$version-amd64 \
$username/$project:v$version-arm64 || { echo "Manifest creation failed or already exists"; exit 1; }

# Push the manifest to Docker Hub as a new version.
docker login && docker manifest push $username/$project:v$version || { echo "Manifest push failed"; exit 1; }

# Create a manifest (package the platform images) to push to Docker Hub as latest.
docker login && docker manifest rm $username/$project:latest || echo "Manifest removal failed."
docker login && docker manifest create $username/$project:latest \
$username/$project:v$version-amd64 \
$username/$project:v$version-arm64 || { echo "Manifest creation failed"; exit 1; }

# Push the manifest to Docker Hub as a new version.
docker login && docker manifest push $username/$project:latest || { echo "Manifest push failed"; exit 1; }

