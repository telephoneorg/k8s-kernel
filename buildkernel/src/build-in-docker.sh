#!/bin/bash

VERSION=$1

if [[ -z "${VERSION}" ]]; then
    echo "Syntax: $0 <version>"
    echo "  where version is an official kernel version, e.g. 4.4.39"
    exit 1
fi

set -ex

REVISION=k8s
KDEB_PKGVERSION=${VERSION}
CODENAME=$(cat /etc/apt/sources.list  | head -1 | awk '{print $3}')

gpg2 --import /src/38DBBDC86092693E.asc

mkdir /build
pushd /build
    wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${VERSION}.tar.xz
    wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${VERSION}.tar.sign

    # Check signature
    xz -cd linux-${VERSION}.tar.xz | gpg2 --verify linux-${VERSION}.tar.sign -

    rm -rf linux-${VERSION} || true
    tar xf linux-${VERSION}.tar.xz
    cp /src/config-${VERSION} linux-${VERSION}/.config
    pushd linux-${VERSION}
        make clean
        make -j $(nproc) deb-pkg LOCALVERSION=-k8s KDEB_PKGVERSION=${KDEB_PKGVERSION}
        popd
    popd

echo "equivs-build ..."
pushd /src/meta
    equivs-build linux-image-k8s
    equivs-build linux-headers-k8s
    popd

cp /build/*.deb /dist/
cp /build/*.dsc /dist/
cp /build/*.tar.gz /dist/
