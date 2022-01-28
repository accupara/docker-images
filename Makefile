# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

SUBDIRS=\
	baseimages \
	business-cards django-nginx qemu duperemove mozilla chromium sonic \
	mobile cpython pyinstaller java cncf db \
	jobserver stress certbot libdeploy gitstatic coreboot tensorflow libra samba \
	ti \
	aosp agl \
    golang-apps \
    tak
# incomplete or untested: ffmpeg yocto dpdk gcc glibc

include $(shell git rev-parse --show-toplevel)/Makefile.subdirs

recreate_all_android:
	$(MAKE) -C baseimages/android         build push
	$(MAKE) -C qt/qt5/android             build push
	$(MAKE) -C qt/apps/subsurface/android build push
