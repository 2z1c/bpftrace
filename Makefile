IMAGE=bpftrace-static
build_docker:

	docker buildx build --platform linux/arm64 -f docker/Dockerfile.arm64.static -t ${IMAGE} --load docker/

build_bpftrace:
	docker run -v $(shell pwd):$(shell pwd) -w $(shell pwd) -it ${IMAGE} /bin/bash