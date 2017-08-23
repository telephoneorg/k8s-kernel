#!/bin/bash

BASE=$(dirname $0)
VERSION=$1

if [[ -z "${VERSION}" ]]; then
	echo "Syntax: $0 <version>"
	echo "  where version is an official kernel version, e.g. 4.4.39"
  exit 1
fi

set -ex

mkdir -p dist/${VERSION}

docker build -f $BASE/src/images/builder/Dockerfile -t kernelbuilder $BASE/src

docker run --rm -v $(realpath $BASE/..)/dist/${VERSION}:/dist kernelbuilder /src/build-in-docker.sh ${VERSION}
