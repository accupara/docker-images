# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

SUBDIRS=\
	baseimages \
	business-cards django-nginx qemu duperemove mozilla chromium sonic \
	mobile cpython java cncf db \
	jobserver stress certbot libdeploy gitstatic coreboot tensorflow diem samba \
	ti \
	aosp yocto agl \
    golang-apps \
    tak \
	dpdk gcc glibc
# incomplete or untested: ffmpeg

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

everything_dir_protocolbuffers: everything_dir_linuxkernel
everything_dir_agl: everything_dir_yocto
everything_dir_%:
	./useme/build.py -C $* -j `nproc`
	-$(MAKE) -C $* manifest -k -j `nproc`

DIRS=\
	 agl \
	 aosp \
	 apache \
	 certbot \
	 chromium \
	 cncf \
	 cpython \
	 db \
	 diem \
	 dpdk \
	 duperemove \
	 ffmpeg \
	 gcc \
	 glibc \
	 godotengine \
	 java \
	 linuxkernel \
	 protocolbuffers \
	 remake \
	 rsync \
	 samba \
	 tak \
	 tensorflow \
	 verilator \
	 yocto
everything_dirs: $(foreach dir,${DIRS},everything_dir_${dir})

everything:
	$(MAKE) -j4 everything_phase2
	$(MAKE) -j4 everything_dirs
