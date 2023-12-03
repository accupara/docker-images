# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved

SUBDIRS=\
	baseimages \
	business-cards django-nginx qemu duperemove mozilla chromium sonic \
	mobile cpython java cncf db \
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

######################################################################
.PHONY: everything_phase1 everything_phase2 everything
everything_phase1:
	./useme/build.py -C baseimages/phase1 -j `nproc`
	-$(MAKE) -C baseimages/phase1 manifest -k -j `nproc`

everything_phase2: everything_phase1
	./useme/build.py -C baseimages/phase2 -j `nproc`
	-$(MAKE) -C baseimages/phase2 manifest -k -j `nproc`

everything_dir_%:
	./useme/build.py -C $* -j `nproc`
	-$(MAKE) -C $* manifest -k -j `nproc`

DIRS=linuxkernel tak db java cncf apache aosp yocto business-cards rsync
everything_dirs: $(foreach dir,${DIRS},everything_dir_${dir})

everything:
	$(MAKE) -j4 everything_phase2
	$(MAKE) -j4 everything_dirs
