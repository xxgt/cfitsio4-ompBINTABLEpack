SHELL := /bin/bash

all: utils

utils:
	cd ./cfitsio-4.1.0 && ./configure && C_FLAGS=`grep "CFLAGS =" < Makefile` \
	&& echo $${C_FLAGS} && echo "$${C_FLAGS:9} -fopenmp" && CFLAGS="$${C_FLAGS:9} -fopenmp" ./configure --prefix=/usr/local --enable-reentrant \
		&& make && make fpack && make funpack

install:
	cd ./cfitsio-4.1.0 && make install

clean:
	cd ./cfitsio-4.1.0 && make clean