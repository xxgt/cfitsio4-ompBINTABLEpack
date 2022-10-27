FROM gcc:12.2.0

COPY cfitsio-4.1.0 /source/cfitsio-4.1.0
COPY Makefile /source/Makefile
RUN cd /source && make build-local && make install-local

RUN cd /cfitsio/usr/local/bin && strip * \
    && cd /cfitsio/usr/local/lib && strip libcfitsio.a libcfitsio.so.9.4.1.0

FROM debian:11-slim

RUN apt-get update --quiet > /dev/null \
    && apt-get install -y libgomp1 libcurl4 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=0 /cfitsio /

ENV LD_LIBRARY_PATH=/usr/local/lib

