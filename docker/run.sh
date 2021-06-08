#! /bin/bash

# to use the 15.3 based image run:
#
#   ./run.sh registry.opensuse.org/yast/head/containers_15.3/yast-ruby:latest
#

# allow customizing the base Docker image
IMAGE=${1:-registry.opensuse.org/yast/head/containers/yast-ruby:latest}

# build the docker image first (it reuses the built image in the next run)
docker build --build-arg image="$IMAGE" -t widget-demo .

# get the absolute path to the top source directory,
# docker does not allow using relative paths for volumes
topdir="$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")"

# start the container with extra "-e" and "-v" options to allow accessing
# the local X server from inside the Docker container
docker run -it -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro --net=host \
    -v "$HOME/.Xauthority:/root/.Xauthority:ro" -v "$topdir:/usr/src/app:ro" \
    --rm widget-demo
