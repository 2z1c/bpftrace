.PHONY: all clean install uninstall builddocker build

IMAGE=yt/bpftrace-static:latest

builddocker:
	docker buildx  build -f docker/Dockerfile.ytstatic --platform=linux/arm64 -t ${IMAGE} --load . 

shell:
	docker run -v $(PWD):$(PWD) -w $(PWD) -it ${IMAGE} /bin/bash

build:
	cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE=ON -DBUILD_TESTING=OFF -DSTATIC_LINKING=ON
	make -C build -j22