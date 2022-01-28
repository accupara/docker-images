# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
IMGTAG?=accupara/xpra
IMGVER?=16.04

CTR_NAME?=xpra

include $(shell git rev-parse --show-toplevel)/Makefile.build

1_start_daemon:
	docker run -d -p 2022:22 --name $(CTR_NAME) $(IMGTAG):$(IMGVER)
	docker cp ~/.ssh/id_rsa.pub $(CTR_NAME):/tmp/useme
	docker exec $(CTR_NAME) bash -c "cat /tmp/useme >> ~/.ssh/authorized_keys"

2_enter:
	docker exec -it $(CTR_NAME) bash

3_attach:
	xpra --ssh="ssh -o 'UserKnownHostsFile /dev/null' -o 'StrictHostKeyChecking no' -p 2022" attach ssh:admin@localhost:100

4_kill:
	-docker kill $(CTR_NAME)
	-docker rm $$(docker ps -aq)
