# Copyright (c) 2016-2018 Accupara Inc. All rights reserved

SUBDIRS=baseimages business-cards django-nginx linuxkernel rsync qt qemu duperemove mozilla mobile circleci pyinstaller chromium java jobserver stress certbot k8s
# incomplete or untested: ffmpeg vlc yocto dpdk gcc glibc

include $(shell git rev-parse --show-toplevel)/Makefile.subdirs

recreate_all_android:
	$(MAKE) -C baseimages/android         build push
	$(MAKE) -C qt/qt5/android             build push
	$(MAKE) -C qt/apps/subsurface/android build push
