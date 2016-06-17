# Copyright (c) 2016 Accupara Inc. All rights reserved
IMGTAG?=accupara/ubuntu
IMGVER?=15.10

all: clean
	docker build -t $(IMGTAG):$(IMGVER) .

clean:
	-docker rmi $$(docker images | awk '{ if ($$1 == "$(IMGTAG)" && $$2 == "$(IMGVER)") { print $$1":"$$2 } }')
	-docker rmi $$(docker images | awk '{ if ($$1 == "ubuntu" && $$2 == "$(IMGVER)") { print $$3 } }')

push:
	docker push $(IMGTAG):$(IMGVER)

pull:
	docker pull $(IMGTAG):$(IMGVER)

it:
	-docker run --rm -it -v ~/code/:/tmp/code $(IMGTAG):$(IMGVER) /bin/bash
