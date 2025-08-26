.PHONY: all clean install uninstall builddocker

IMAGE=yt/bpftrace-static:latest

builddocker:
	docker buildx  build -f docker/Dockerfile.ytstatic --platform=linux/arm64 -t ${IMAGE} --load . 

shell:
	docker run -v $(PWD):$(PWD) -w $(PWD) -it ${IMAGE} /bin/bash

build:
