IMGTAG=uvatbc/bbndk
IMGVER=latest

CONTAINER_NAME=savethis

.PHONY: help clean run_sshd run_setup run_qt5_compile run_ssh_bash commit_container push pull it

help:
	@echo 'Start off with "make run_sshd" first.'
	@echo 'In another terminal, run the following in order:'
	@echo '"make copy_files"'
	@echo '"make run_setup"'
	@echo 'After run_setup ends, it might be necessart to "make run_ssh_bash" and run ~/bin/bbndk/qde'
	@echo 'In the end, quit the "make run_sshd" using Ctrl+C. This will commit the container'

clean:
	-docker rmi $$(docker images | awk '{ if ($$1 == "$(IMGTAG)" && $$2 == "$(IMGVER)") { print $$1":"$$2 } }')
	-docker rm $$(docker ps -aq)
	rm -rf /tmp/bbndk

run_sshd: clean
	-docker run -it --name ${CONTAINER_NAME} uvatbc/sshd
	${MAKE} commit_container

copy_files:
	ssh-copy-id \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		admin@`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}`
	scp \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		setup.sh \
		admin@`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}`:/tmp/

run_setup:
	ssh -C -Y \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		admin@`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}` \
		'/tmp/setup.sh'

run_qt5_compile:
	ssh -C -Y \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		admin@`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}` \
		'cd ~/code/qt5/ ; ./bb10_build_qt5.sh'

run_ssh_bash:
	ssh -C -Y \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		admin@`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}`

commit_container:
	-docker rmi $$(docker images | awk '{ if ($$1 == "$(IMGTAG)" && $$2 == "$(IMGVER)") { print $$1":"$$2 } }')
	docker commit \
		--change 'CMD ["sudo", "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]' \
		${CONTAINER_NAME} \
		$(IMGTAG):$(IMGVER)
	-docker rm $$(docker ps -aq)

push:
	docker push $(IMGTAG):$(IMGVER)

pull:
	docker pull $(IMGTAG):$(IMGVER)

it:
	-docker run --rm -it -v ~/code:/tmp/code $(IMGTAG):$(IMGVER) /bin/bash
