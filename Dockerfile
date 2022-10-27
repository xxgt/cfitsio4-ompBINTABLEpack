FROM gcc:12.2.0

ADD . /source
RUN cd /source && make utils && make install