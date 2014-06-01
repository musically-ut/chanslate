.PHONY: Dockerfile

VERSION = $(shell git describe)

Dockerfile:
	cat Dockerfile.template | sed "s/__VERSION/$(VERSION)/g" > Dockerfile

docker.image: Dockerfile
	docker build -t musicallyut/chanslate:$(VERSION) .

docker.push:
	docker push musicallyut/chanslate:$(VERSION)

