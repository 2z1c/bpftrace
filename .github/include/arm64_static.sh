#!/bin/bash
#
# This script is the entrypoint for the static build.
#
# To make CI errors easier to reproduce locally, please limit
# this script to using only git, docker, and coreutils.

set -eux

IMAGE=bpftrace-static
cd $(git rev-parse --show-toplevel)

# Build the base image
docker buildx build --platform linux/arm64 -f docker/Dockerfile.arm64.static -t "$IMAGE" --load docker/

# docker build -t "$IMAGE" -f docker/Dockerfile.arm64.static docker/
# show image
docker images
# Perform bpftrace static build

docker run -v $(pwd):$(pwd) -w $(pwd) -i "$IMAGE" <<'EOF'
set -eux
BUILD_DIR=build-static
cmake -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE=ON -DBUILD_TESTING=OFF -DSTATIC_LINKING=ON
make -C "$BUILD_DIR" V=1 CXXFLAGS="-fPIC -static" -j$(nproc) bpftrace

# Basic smoke test
./"$BUILD_DIR"/src/bpftrace --help
file $(pwd)/build-static/src/bpftrace
EOF


