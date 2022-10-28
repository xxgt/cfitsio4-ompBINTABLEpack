SHELL := /bin/bash
IMAGE_NAME=cfitsio-omp-pack

build:
	docker build --network host -t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)

build-local:
	cd ./cfitsio-4.1.0 && ./configure && C_FLAGS=`grep "CFLAGS =" < Makefile` \
		&& echo $${C_FLAGS} && echo "$${C_FLAGS:9} -fopenmp" \
		&& CFLAGS="$${C_FLAGS:9} -fopenmp" ./configure --prefix=/cfitsio/usr/local --enable-reentrant \
		&& make && make fpack && make funpack

install-local:
	cd ./cfitsio-4.1.0 && make install
