MAKEFLAGS += --silent

.PHONY: build run

IMAGE_NAME := slijirqqq/dot-config:fedora

build:
	docker build -t $(IMAGE_NAME) -f tests/dockerfiles/fedora/fedora.dockerfile .

run:
	docker run --rm -v $(CURDIR):/opt/dot-config $(IMAGE_NAME) python -m dot-config install-zsh
