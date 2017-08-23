#!/usr/bin/env bash

VERSION=$1

if [[ -z "${VERSION}" ]]; then
	echo "Syntax: $0 <version>"
	echo "  where version is an official kernel version, e.g. 4.4.39"
  exit 1
fi

set -ex

CONFIG_PATH="buildkernel/src/config-${VERSION}"

sed -i '/CONFIG_DEBUG_INFO/s/y/n/' "$CONFIG_PATH"
sed -i 's/# \(CONFIG_MEMCG_SWAP_ENABLED\) is not set/\1=y/' "$CONFIG_PATH"
sed -i 's/# \(CONFIG_MEMCG_KMEM\) is not set/\1=y/' "$CONFIG_PATH"
sed -i 's/# \(CONFIG_CGROUP_HUGETLB\) is not set/\1=y/' "$CONFIG_PATH"
