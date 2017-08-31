# k8s Kernel
[![Build Status](https://drone.valuphone.com/api/badges/joeblackwaslike/k8s-kernel/status.svg)](https://drone.valuphone.com/joeblackwaslike/k8s-kernel) [![Github Repo](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/joeblackwaslike/k8s-kernel)


## Maintainer
Joe Black | <me@joeblack.nyc> | [github](https://github.com/joeblackwaslike)


## Introduction
This is a 4.9.x kernel built for running Kubernetes.

This is a fork from the original repo and has the following changes:
* config file additions:
    * `CONFIG_MEMCG_SWAP_ENABLED`=y
    * `CONFIG_MEMCG_KMEM`=y
    * `CONFIG_CGROUP_HUGETLB`=y
    * `CONFIG_DEBUG_INFO`=n

Currently it only builds a Debian kernel.

It has the following changes:
* 4.4 kernel
* cgroup memory controller is enabled


## Building
Check out the code into ~: `cd ~; git clone https://github.com/joeblackwaslike/k8s-kernel.git`

Note: if docker is not using overlay, it will likely fail during the kernel build.

Then build the kernel image: `make kernel`

The new kernel packages will be in `dist`.
