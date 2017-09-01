FROM buildpack-deps:stretch

RUN apt-get update -qq
RUN apt-get install -yqq \
        bc \
        build-essential \
        equivs \
        fakeroot \
        git \
        gnupg2 \
        ncurses-dev \
        wget

ADD . /src

ENTRYPOINT ["/src/entrypoint"]

CMD ["4.9.46"]
