VERSION ?= 4.9.46
CODENAME ?= stretch

BASE := $(realpath $(dir $(MAKEFILE_LIST)))
CONFIG_PATH := $(BASE)/kernel-builder/src/configs/config-$(VERSION)

.PHONY: build build-builder build-kernel clean enable-cgroups templates test
.PHONY: pre-build

build: pre-build build-builder build-kernel

enable-cgroups:
	sed -i '/CONFIG_DEBUG_INFO/s/y/n/' $(CONFIG_PATH)
	sed -i 's/# \(CONFIG_MEMCG_SWAP_ENABLED\) is not set/\1=y/' $(CONFIG_PATH)
	sed -i 's/# \(CONFIG_MEMCG_KMEM\) is not set/\1=y/' $(CONFIG_PATH)
	sed -i 's/# \(CONFIG_CGROUP_HUGETLB\) is not set/\1=y/' $(CONFIG_PATH)

pre-build:
	@mkdir -p $(BASE)/kernel-builder/dist/$(VERSION)

build-builder:
	@docker build -t kernel-builder \
		-f $(BASE)/kernel-builder/src/images/builder/Dockerfile \
		$(BASE)/kernel-builder/src

build-kernel:
	@docker run --rm \
		-v $(BASE)/kernel-builder/dist/$(VERSION):/dist \
		kernel-builder $(VERSION)

clean:
	@rm -rf buildkernel/dist/* buildkernel/dist/.*
	@rm -rf dist/*

test:
	for pkg in firmware-image headers image libc-dev; do \
		test -f dist/$(VERSION)/linux-$${pkg}*; \
	done

templates:
	@tmpld --strict --data templates/vars.yaml templates/*.j2
