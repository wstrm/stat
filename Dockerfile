FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

ADD . /br2-external
VOLUME /tmp/result

RUN apt-get -qqy update
RUN apt-get -qqy install patch cpio python unzip rsync bc bzip2 ncurses-dev git make g++ gawk wget flex bison

RUN useradd -ms /bin/bash bob
USER bob
WORKDIR /home/bob

RUN wget -qO- https://buildroot.org/downloads/buildroot-2018.02.tar.gz | tar xz --strip 1
