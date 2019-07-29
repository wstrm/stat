FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update
RUN apt-get -qqy install patch cpio python unzip rsync bc bzip2 ncurses-dev git make g++ gawk wget flex bison gcc-multilib g++-multilib

RUN useradd -ms /bin/bash bob
USER bob

WORKDIR /home/bob

COPY --chown=bob . .
ENV PATH="${PATH}:/home/bob/bin"

RUN git submodule update --recursive

VOLUME output

CMD build raspberrypi2_stat_defconfig
