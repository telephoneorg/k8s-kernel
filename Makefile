VERSION ?= 4.4.78
CODENAME ?= stretch

.PHONY: kernel clean templates test

kernel:
	scripts/enable-extras.sh $(VERSION)
	cd buildkernel && ./build.sh $(VERSION)

clean:
	rm -rf buildkernel/dist/* buildkernel/dist/.*
	rm -rf dist/*

test:
	for pkg in firmware-image headers image libc-dev; do \
		test -f /dist/$(VERSION)/linux-$${pkg}*; \
	done

templates:
	tmpld --strict --data templates/vars.yaml templates/*.j2
