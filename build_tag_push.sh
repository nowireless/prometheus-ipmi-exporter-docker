#! /usr/bin/env bash

VERSION=$(cat .version)
IMAGE_TAG="ghcr.io/nowireless/ipmi_exporter:$VERSION"
docker build . -t "$IMAGE_TAG"

docker push "$IMAGE_TAG"