# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved

SUBDIRS=\
	baseimages \
	business-cards django-nginx qemu duperemove mozilla chromium sonic mono \
	mobile cpython java cncf db \
	stress certbot libdeploy gitstatic coreboot tensorflow diem samba \
	ti \
	aosp yocto agl \
    golang-apps \
    tak \
	dpdk gcc glibc \
	cobol criu
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
	 cobol \
	 cpython \
	 criu \
	 db \
	 diem \
	 dpdk \
	 duperemove \
	 emscripten \
	 ffmpeg \
	 gcc \
	 glibc \
	 godotengine \
	 java \
	 linuxkernel \
	 mono \
	 protocolbuffers \
	 qemu \
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

everything_manifests:
	${MAKE} -C baseimages/phase1 manifest -k
	${MAKE} -C baseimages/phase2 manifest -k
	for i in $(foreach dir,${DIRS},everything_dir_${dir}) ; do \
		make -C $$i manifest -k ; \
	done
