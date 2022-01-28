# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
IMGTAG?=accupara/bbndk
IMGVER?=latest

MOMENTICS_FILE?=momentics-2.1.2-201503050937.linux.x86_64.run
STARTING_CTR?=accupara/xpra:18.04
CONTAINER_NAME?=savethis

.PHONY: help clean build commit_container push pull it

help:
	@echo 'Start off with "make build".'
	@echo 'It will copy the setup files, start it in xpra and then attach to that xpra session'
	@echo 'After everything is installed, disconnect from the xpra session.'
	@echo 'The container will be commited into an image.'

clean:
	-docker kill $(CONTAINER_NAME)
	-docker rmi $$(docker images | awk '{ if ($$1 == "$(IMGTAG)" && $$2 == "$(IMGVER)") { print $$1":"$$2 } }')
	-docker rm $$(docker ps -aq)
	rm -rf /tmp/bbndk

ensure_momentics_installer:
	if [ ! -f $(MOMENTICS_FILE) ] ; then wget https://developer.blackberry.com/native/downloads/fetch/$(MOMENTICS_FILE) ; fi

build: clean ensure_momentics_installer
	docker run -d -p 2022:22 --name $(CONTAINER_NAME) $(STARTING_CTR)
	docker cp ~/.ssh/id_rsa.pub $(CONTAINER_NAME):/tmp/useme
	docker exec $(CONTAINER_NAME) bash -c "cat /tmp/useme >> ~/.ssh/authorized_keys"
	docker cp setup.sh $(CONTAINER_NAME):/tmp/
	docker cp $(MOMENTICS_FILE) $(CONTAINER_NAME):/tmp/
	docker exec $(CONTAINER_NAME) /tmp/setup.sh
	xpra \
		--ssh="ssh -o 'UserKnownHostsFile /dev/null' -o 'StrictHostKeyChecking no' -p 2022" \
		attach ssh:admin@localhost:100
	$(MAKE) commit_container

dont_use_copy_files: ensure_momentics_installer
	ssh-copy-id \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		admin@`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}`
	scp \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		setup.sh $(MOMENTICS_FILE) \
		admin@`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}`:/tmp/

# How to figure out what environment variables to add here:
# Run the accupara/bbndk container and run:
# for i in `grep export ~/bin/bbndk/bbndk-env_10_3_1_995.sh | sed -s 's/export //g'` ; do grep $i /tmp/op.txt ; done
# The last run gave the following output:
#
# QNX_TARGET=/home/admin/bin/bbndk/target_10_3_1_995/qnx6
# QNX_HOST=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86
# QNX_CONFIGURATION=/home/admin/.rim/bbndk
# MAKEFLAGS=-I/home/admin/bin/bbndk/target_10_3_1_995/qnx6/usr/include
# LD_LIBRARY_PATH=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/lib:/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt4/lib:
# QML2_IMPORT_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/qml
# LD_LIBRARY_PATH=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/lib:/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt4/lib:
# PATH=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/bin:/home/admin/.rim/bbndk/bin:/home/admin/bin/bbndk/features/com.qnx.tools.jre.linux.x86_64_1.7.0.51/jre/bin:/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/python32/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# QT_LIB_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/lib
# QT_PLUGIN_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/plugins
# QDE=/home/admin/bin/bbndk
# CPUVARDIR=armle-v7
# QT_PLUGIN_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/plugins
# QT_LIB_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/lib
# QML2_IMPORT_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/qml
#
# Pull out the unique values out of this and use it
commit_container:
	-docker rmi $$(docker images | awk '{ if ($$1 == "$(IMGTAG)" && $$2 == "$(IMGVER)") { print $$1":"$$2 } }')
	-docker kill $(CONTAINER_NAME)
	docker commit \
		--change 'CMD ["sudo", "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]' \
		--change 'ENV QNX_TARGET=/home/admin/bin/bbndk/target_10_3_1_995/qnx6 QNX_HOST=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86 QNX_CONFIGURATION=/home/admin/.rim/bbndk MAKEFLAGS=-I/home/admin/bin/bbndk/target_10_3_1_995/qnx6/usr/include LD_LIBRARY_PATH=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/lib:/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt4/lib QML2_IMPORT_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/qml LD_LIBRARY_PATH=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/lib:/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt4/lib: PATH=/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/bin:/home/admin/.rim/bbndk/bin:/home/admin/bin/bbndk/features/com.qnx.tools.jre.linux.x86_64_1.7.0.51/jre/bin:/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/python32/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin QT_LIB_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/lib QT_PLUGIN_PATH=/home/admin/bin/bbndk/target_10_3_1_995/qnx6/../linux/x86/usr/lib/qt5/plugins QDE=/home/admin/bin/bbndk CPUVARDIR=armle-v7' \
		$(CONTAINER_NAME) \
		$(IMGTAG):$(IMGVER)
	-docker rm $$(docker ps -aq)

push:
	docker push $(IMGTAG):$(IMGVER)

pull:
	docker pull $(IMGTAG):$(IMGVER)

it:
	-docker run --rm -it -v ~/:/tmp/home $(IMGTAG):$(IMGVER) /bin/bash
