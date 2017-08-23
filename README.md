# k8s Kernel

This is a 4.4 kernel built for running Kubernetes.

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
Check out the code into ~: `cd ~; git clone https://github.com/{{ github_user }}/{{ github_repo }}.git`

Note: if docker is not using overlay, it will likely fail during the kernel build.

Then build the kernel image: `make kernel`

The new kernel packages will be in `dist`.
