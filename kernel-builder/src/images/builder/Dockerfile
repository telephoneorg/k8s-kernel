FROM buildpack-deps:stretch

MAINTAINER Joe Black <me@joeblack.nyc>

RUN apt-get update -qq
RUN apt-get install -yqq \
        bc \
        build-essential \
        equivs \
        fakeroot \
        git \
        gnupg2 \
        lsb-release \
        ncurses-dev \
        wget

ADD . /src

ENV KERNEL_VERSION 4.9.46

ENTRYPOINT ["/src/entrypoint"]

CMD ["$KERNEL_VERSION"]
