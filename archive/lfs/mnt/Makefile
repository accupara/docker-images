# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

lfs_home = /mnt/lfs
lfs_target = $(shell uname -m)-lfs-linux-gnu
lfs_builddir = $(lfs_home)/build
lfs_sources  = $(lfs_home)/sources

all:
	@echo "run: make sources setup build"
	@echo "other options: phase-1, build_clean, finalize_p2"

#################################################################
sources:
	mkdir -pv $(lfs_sources)
	chmod -v a+wt $(lfs_sources)
	wget --input-file=wget-list --continue --directory-prefix=$(lfs_sources)

#################################################################
setup: setup_env

setup_env: setup_tools
	echo "set +h" >> ~/.bashrc
	echo "umask 022" >> ~/.bashrc
	echo "LFS=$(lfs_home)" >> ~/.bashrc
	echo "LC_ALL=POSIX" >> ~/.bashrc
	echo "LFS_TGT=$(lfs_target)" >> ~/.bashrc
	echo "PATH=/tools/bin:/bin:/usr/bin" >> ~/.bashrc
	echo "export LFS LC_ALL LFS_TGT PATH" >> ~/.bashrc
	@echo
	@echo "###################################################"
	@echo " ~/.bashrc has changed. please re-source the file #"
	@echo "###################################################"

setup_tools: setup_lfs
	mkdir -pv $(lfs_home)/tools
	sudo ln -sv $(lfs_home)/tools /

setup_lfs:
	sudo chown -R 1000.1000 /mnt
	mkdir -pv $(lfs_home)

#################################################################
build: build_gcc_full

lfs_build_setup:
	mkdir -pv $(lfs_builddir)
	mkdir -pv /tools/lib && ln -svf lib /tools/lib64
	. ~/.bashrc

build_clean:
	rm -rf $(lfs_builddir)


#################################################################
# binutils                                                      #
#################################################################
binutils-phase-1: binutils_clean

binutils_clean: binutils_install
	rm -rf $(lfs_builddir)/binutils-build
	rm -rf $(lfs_builddir)/binutils-2.26

binutils_install: binutils_build
	$(MAKE) -C $(lfs_builddir)/binutils-build install

binutils_build: binutils_setup
	$(MAKE) -C $(lfs_builddir)/binutils-build

binutils_setup: lfs_build_setup
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: binutils-phase-1"
	@echo "###################################################"
	mkdir -pv $(lfs_builddir)/binutils-build
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/binutils-2.26.tar.bz2
	cd $(lfs_builddir)/binutils-build && ../binutils-2.26/configure --prefix=/tools --with-sysroot=$(lfs_home) --with-lib-path=/tools/lib --target=$(lfs_target) --disable-nls --disable-werror


#################################################################
# gcc                                                           #
#################################################################
gcc-phase-1: gcc_clean

gcc_clean: gcc_install
	rm -rf $(lfs_builddir)/gcc-build
	rm -rf $(lfs_builddir)/gcc-6.1.0

gcc_install: gcc_build
	$(MAKE) -C $(lfs_builddir)/gcc-build install

gcc_build: gcc_configure
	$(MAKE) -C $(lfs_builddir)/gcc-build

gcc_configure: gcc_setup
	mkdir -pv $(lfs_builddir)/gcc-build
	cd $(lfs_builddir)/gcc-build && 		       	\
	../gcc-6.1.0/configure                         	\
    --target=$(lfs_target)							\
    --prefix=/tools                                	\
    --with-glibc-version=2.11                      	\
    --with-sysroot=$(lfs_home)						\
    --with-newlib                                  	\
    --without-headers                              	\
    --with-local-prefix=/tools                     	\
    --with-native-system-header-dir=/tools/include 	\
    --disable-nls                                  	\
    --disable-shared                               	\
    --disable-multilib                             	\
    --disable-decimal-float                        	\
    --disable-threads                              	\
    --disable-libatomic                            	\
    --disable-libgomp                              	\
    --disable-libmpx                               	\
    --disable-libquadmath                          	\
    --disable-libssp                               	\
    --disable-libvtv                               	\
    --disable-libstdcxx                            	\
    --enable-languages=c,c++

gcc_setup: binutils-phase-1
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: gcc-phase-1"
	@echo "###################################################"
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/gcc-6.1.0.tar.bz2
	tar -C $(lfs_builddir) -xf $(lfs_sources)/mpfr-3.1.4.tar.xz
	mv $(lfs_builddir)/mpfr-3.1.4 $(lfs_builddir)/gcc-6.1.0/mpfr
	tar -C $(lfs_builddir) -xf $(lfs_sources)/gmp-6.1.0.tar.xz
	mv -v $(lfs_builddir)/gmp-6.1.0 $(lfs_builddir)/gcc-6.1.0/gmp
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/mpc-1.0.3.tar.gz
	mv -v $(lfs_builddir)/mpc-1.0.3 $(lfs_builddir)/gcc-6.1.0/mpc
	cd $(lfs_builddir)/gcc-6.1.0 && /mnt/gcc-setup.sh

#################################################################
# Linux API headers                                             #
#################################################################
linux_api_headers-phase-1: lah_clean

lah_clean: lah_install
	rm -rf $(lfs_builddir)/linux-4.6.2

lah_install: lah_mrproper
	$(MAKE) -C $(lfs_builddir)/linux-4.6.2 INSTALL_HDR_PATH=dest headers_install
	cd $(lfs_builddir)/linux-4.6.2 && cp -rv dest/include/* /tools/include

lah_mrproper: lah_extract
	$(MAKE) -C $(lfs_builddir)/linux-4.6.2 mrproper

lah_extract: gcc-phase-1
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: linux-build-headers-phase-1"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/linux-4.6.2.tar.xz


#################################################################
# Glibc														    #
#################################################################
glibc-phase-1: glibc_clean

glibc_clean: glibc_install
	rm -rf $(lfs_builddir)/glibc-build
	rm -rf $(lfs_builddir)/glibc-2.23

glibc_install: glibc_build
	$(MAKE) -C $(lfs_builddir)/glibc-build install

glibc_build: glibc_configure
	# force this to be single threaded since
	# compilation sometimes fails because of
	# parallel execution.
	$(MAKE) -C $(lfs_builddir)/glibc-build

glibc_configure: glibc_setup
	cd $(lfs_builddir)/glibc-build &&	\
	../glibc-2.23/configure				\
	--prefix=/tools						\
	--host=$(lfs_target)				\
	--build=$(shell cd $(lfs_builddir)/glibc-build && ../glibc-2.23/scripts/config.guess)	\
	--disable-profile					\
	--enable-kernel=2.6.32				\
	--enable-obsolete-rpc				\
	--with-headers=/tools/include		\
	libc_cv_forced_unwind=yes			\
	libc_cv_ctors_header=yes			\
	libc_cv_c_cleanup=yes

glibc_setup: linux_api_headers-phase-1
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: glibc-phase-1"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/glibc-2.23.tar.xz
	cd $(lfs_builddir)/glibc-2.23 && patch -Np1 -i $(lfs_sources)/glibc-2.23-upstream_fixes-1.patch
	mkdir -pv $(lfs_builddir)/glibc-build

#################################################################
# Libstdc++														#
#################################################################
libstdcpp-phase-1: libstdcpp_clean

libstdcpp_clean: libstdcpp_install
	rm -rf $(lfs_builddir)/gcc-build
	rm -rf $(lfs_builddir)/gcc-6.1.0

libstdcpp_install: libstdcpp_build
	$(MAKE) -C $(lfs_builddir)/gcc-build install

libstdcpp_build: libstdcpp_configure
	$(MAKE) -C $(lfs_builddir)/gcc-build

libstdcpp_configure: libstdcpp_setup
	cd $(lfs_builddir)/gcc-build &&		\
	../gcc-6.1.0/libstdc++-v3/configure	\
	--host=$(lfs_target)				\
	--prefix=/tools						\
	--disable-multilib					\
	--disable-nls						\
	--disable-libstdcxx-threads			\
	--disable-libstdcxx-pch				\
	--with-gxx-include-dir=/tools/$(lfs_target)/include/c++/6.1.0

libstdcpp_setup: glibc-phase-1
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: libstdc++ phase-1"
	@echo "###################################################"
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/gcc-6.1.0.tar.bz2
	mkdir -pv $(lfs_builddir)/gcc-build

#################################################################
phase-1: libstdcpp-phase-1

#################################################################
# Binutils - phase 2											#
#################################################################

binutils-p2: binutils_clean-p2

binutils_clean-p2: binutils_install-p2
	rm -rf $(lfs_builddir)/binutils-build
	rm -rf $(lfs_builddir)/binutils-2.26

binutils_install-p2: binutils_build-p2
	$(MAKE) -C $(lfs_builddir)/binutils-build install
	cd $(lfs_builddir)/binutils-build && $(MAKE) -C ld clean
	cd $(lfs_builddir)/binutils-build && $(MAKE) -C ld LIB_PATH=/usr/lib:/lib
	cd $(lfs_builddir)/binutils-build && cp -v ld/ld-new /tools/bin

binutils_build-p2: binutils_setup-p2
	$(MAKE) -C $(lfs_builddir)/binutils-build

binutils_setup-p2: libstdcpp-phase-1
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: bintuils phase-2"
	@echo "###################################################"
	mkdir -pv $(lfs_builddir)/binutils-build
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/binutils-2.26.tar.bz2
	cd $(lfs_builddir)/binutils-build &&	\
	CC=$(lfs_target)-gcc					\
	AR=$(lfs_target)-ar						\
	RANLIB=$(lfs_target)-ranlib 			\
	../binutils-2.26/configure			\
	--prefix=/tools							\
	--disable-nls							\
	--disable-werror						\
	--with-lib-path=/tools/lib				\
	--with-sysroot


#################################################################
# GCC - phase 2													#
#################################################################
gcc-phase-2: gcc_clean_2

gcc_clean_2: gcc_install_2
	rm -rf $(lfs_builddir)/gcc-6.1.0
	rm -rf $(lfs_builddir)/gcc-build

gcc_install_2: gcc_build_2
	$(MAKE) -C $(lfs_builddir)/gcc-build install
	cd $(lfs_builddir)/gcc-build && ln -sv gcc /tools/bin/cc

gcc_build_2: gcc_configure_2
	$(MAKE) -C $(lfs_builddir)/gcc-build

gcc_configure_2: gcc_setup_2
	mkdir -pv $(lfs_builddir)/gcc-build
	cd $(lfs_builddir)/gcc-build && 		\
	CC=$(lfs_target)-gcc					\
	CXX=$(lfs_target)-g++					\
	AR=$(lfs_target)-ar						\
	RANLIB=$(lfs_target)-ranlib				\
	../gcc-6.1.0/configure					\
    --prefix=/tools							\
	--with-local-prefix=/tools				\
	--with-native-system-header-dir=/tools/include \
	--enable-languages=c,c++				\
	--disable-libstdcxx-pch					\
	--disable-multilib						\
	--disable-bootstrap						\
	--disable-libgomp

gcc_setup_2: binutils-p2
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: gcc phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/gcc-6.1.0.tar.bz2
	cd $(lfs_builddir)/gcc-6.1.0 && /mnt/gcc-setup_2.sh
	tar -C $(lfs_builddir) -xf $(lfs_sources)/mpfr-3.1.4.tar.xz
	mv $(lfs_builddir)/mpfr-3.1.4 $(lfs_builddir)/gcc-6.1.0/mpfr
	tar -C $(lfs_builddir) -xf $(lfs_sources)/gmp-6.1.0.tar.xz
	mv -v $(lfs_builddir)/gmp-6.1.0 $(lfs_builddir)/gcc-6.1.0/gmp
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/mpc-1.0.3.tar.gz
	mv -v $(lfs_builddir)/mpc-1.0.3 $(lfs_builddir)/gcc-6.1.0/mpc


#################################################################
# Tcl - phase 2													#
#################################################################

tcl: tcl-cleanup

tcl-cleanup: tcl-install
	rm -rf $(lfs_builddir)/tcl-build
	rm -rf $(lfs_builddir)/tcl8.6.5

tcl-install: tcl-build
	$(MAKE) -C $(lfs_builddir)/tcl-build install
	chmod -v u+w /tools/lib/libtcl8.6.so
	$(MAKE) -C $(lfs_builddir)/tcl-build install-private-headers
	cd $(lfs_builddir)/tcl-build && ln -sv tclsh8.6 /tools/bin/tclsh

tcl-test: tcl-build
	TZ=UTC $(MAKE) -C $(lfs_builddir)/tcl-build test

tcl-build: tcl-config
	$(MAKE) -C $(lfs_builddir)/tcl-build

tcl-config: tcl-setup
	cd $(lfs_builddir)/tcl-build &&	../tcl8.6.5/unix/configure --prefix=/tools

tcl-setup: gcc-phase-2
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: tcl phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/tcl-core8.6.5-src.tar.gz
	mkdir -pv $(lfs_builddir)/tcl-build


#################################################################
# Expect - phase 2												#
#################################################################

expect: expect-cleanup

expect-cleanup: expect-install
	rm -rf $(lfs_builddir)/expect-build
	rm -rf $(lfs_builddir)/expect5.45

expect-install: expect-test
	$(MAKE) -C $(lfs_builddir)/expect-build SCRIPTS="" install

expect-test: expect-build
	$(MAKE) -C $(lfs_builddir)/expect-build test

expect-build: expect-config
	$(MAKE) -C $(lfs_builddir)/expect-build

expect-config: expect-setup
	mkdir -pv $(lfs_builddir)/expect-build
	cd $(lfs_builddir)/expect-build && 			\
	../expect5.45/configure --prefix=/tools		\
	--with-tcl=/tools/lib						\
	--with-tclinclude=/tools/include

expect-setup: tcl
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: expect phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/expect5.45.tar.gz
	cd $(lfs_builddir)/expect5.45 && cp -v configure{,.orig}
	cd $(lfs_builddir)/expect5.45 && sed 's:/usr/local/bin:/bin:' configure.orig > configure


#################################################################
# DejaGNU - phase 2												#
#################################################################

dejagnu: deja-cleanup

deja-cleanup: deja-install
	rm -rf $(lfs_builddir)/dejagnu-1.5.3

deja-install: deja-build
	$(MAKE) -C $(lfs_builddir)/dejagnu-1.5.3 install
	$(MAKE) -C $(lfs_builddir)/dejagnu-1.5.3 check

deja-build: deja-configure
	$(MAKE) -C $(lfs_builddir)/dejagnu-1.5.3

deja-configure: expect
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: deja phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/dejagnu-1.5.3.tar.gz
	cd $(lfs_builddir)/dejagnu-1.5.3 && ./configure --prefix=/tools

#################################################################
# Check - phase 2												#
#################################################################

check: dejagnu
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: check phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/check-0.10.0.tar.gz
	cd $(lfs_builddir)/check-0.10.0 && PKG_CONFIG= ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/check-0.10.0
	$(MAKE) -C $(lfs_builddir)/check-0.10.0 check
	$(MAKE) -C $(lfs_builddir)/check-0.10.0 install
	rm -rf $(lfs_builddir)/check-0.10.0

#################################################################
# NCurses - phase 2												#
#################################################################

ncurses: check
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: ncurses phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/ncurses-6.0.tar.gz
	cd $(lfs_builddir)/ncurses-6.0 && sed -i s/mawk// configure
	cd $(lfs_builddir)/ncurses-6.0 && ./configure --prefix=/tools \
	--with-shared		\
	--without-debug		\
	--without-ada		\
	--enable-widec		\
	--enable-overwrite
	$(MAKE) -C $(lfs_builddir)/ncurses-6.0
	$(MAKE) -C $(lfs_builddir)/ncurses-6.0 install
	rm -rf $(lfs_builddir)/ncurses-6.0

#################################################################
# Bash - phase 2												#
#################################################################

bash: ncurses
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: bash phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/bash-4.3.30.tar.gz
	cd $(lfs_builddir)/bash-4.3.30 && ./configure --prefix=/tools --without-bash-malloc
	$(MAKE) -C $(lfs_builddir)/bash-4.3.30
	$(MAKE) -C $(lfs_builddir)/bash-4.3.30 tests
	$(MAKE) -C $(lfs_builddir)/bash-4.3.30 install
	ln -sv bash /tools/bin/sh
	rm -rf $(lfs_builddir)/bash-4.3.30

#################################################################
# Bzip2 - phase 2												#
#################################################################

bzip2: bash
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: bzip2 phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/bzip2-1.0.6.tar.gz
	$(MAKE) -C $(lfs_builddir)/bzip2-1.0.6
	$(MAKE) -C $(lfs_builddir)/bzip2-1.0.6 PREFIX=/tools install
	rm -rf $(lfs_builddir)/bzip2-1.0.6

#################################################################
# Coreutils - phase 2											#
#################################################################

coreutils: bzip2
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: coreutils phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/coreutils-8.25.tar.xz
	cd $(lfs_builddir)/coreutils-8.25 && ./configure --prefix=/tools --enable-install-program=hostname
	$(MAKE) -C $(lfs_builddir)/coreutils-8.25
	# $(MAKE) -C $(lfs_builddir)/coreutils-8.25 check
	# $(MAKE) -C $(lfs_builddir)/coreutils-8.25 check-very-expensive
	$(MAKE) -C $(lfs_builddir)/coreutils-8.25 install
	# Removed because it was causing some failure
	# rm -rf $(lfs_builddir)/coreutils-8.25


#################################################################
# Diffutils - phase 2											#
#################################################################

diffutils: coreutils
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: diffutils phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/diffutils-3.3.tar.xz
	cd $(lfs_builddir)/diffutils-3.3 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/diffutils-3.3
	$(MAKE) -C $(lfs_builddir)/diffutils-3.3 check
	$(MAKE) -C $(lfs_builddir)/diffutils-3.3 install
	rm -rf $(lfs_builddir)/diffutils-3.3

#################################################################
# File - phase 2												#
#################################################################

file: diffutils
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: file phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/file-5.25.tar.gz
	cd $(lfs_builddir)/file-5.25 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/file-5.25
	$(MAKE) -C $(lfs_builddir)/file-5.25 check
	$(MAKE) -C $(lfs_builddir)/file-5.25 install
	rm -rf $(lfs_builddir)/file-5.25

#################################################################
# findutils - phase 2											#
#################################################################

findutils: file
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: findutils phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/findutils-4.4.2.tar.gz
	cd $(lfs_builddir)/findutils-4.4.2 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/findutils-4.4.2
	$(MAKE) -C $(lfs_builddir)/findutils-4.4.2 check
	$(MAKE) -C $(lfs_builddir)/findutils-4.4.2 install
	rm -rf $(lfs_builddir)/findutils-4.4.2

#################################################################
# Gawk - phase 2												#
#################################################################

gawk: findutils
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: gawk phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/gawk-4.1.3.tar.xz
	cd $(lfs_builddir)/gawk-4.1.3 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/gawk-4.1.3
	$(MAKE) -C $(lfs_builddir)/gawk-4.1.3 check
	$(MAKE) -C $(lfs_builddir)/gawk-4.1.3 install
	rm -rf $(lfs_builddir)/gawk-4.1.3

#################################################################
#  gettext - phase 2											#
#################################################################

gettext: gawk
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: gettext phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/gettext-0.19.6.tar.xz
	cd $(lfs_builddir)/gettext-0.19.6/gettext-tools && EMACS="no" ./configure --prefix=/tools --disable-shared
	$(MAKE) -C $(lfs_builddir)/gettext-0.19.6/gettext-tools/gnulib-lib
	$(MAKE) -C $(lfs_builddir)/gettext-0.19.6/gettext-tools/intl pluralx.c
	$(MAKE) -C $(lfs_builddir)/gettext-0.19.6/gettext-tools/src msgfmt
	$(MAKE) -C $(lfs_builddir)/gettext-0.19.6/gettext-tools/src msgmerge
	$(MAKE) -C $(lfs_builddir)/gettext-0.19.6/gettext-tools/src xgettext
	cd $(lfs_builddir)/gettext-0.19.6/gettext-tools && cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
	rm -rf $(lfs_builddir)/gettext-0.19.6


#################################################################
#  grep - phase 2												#
#################################################################

grep: gettext
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: grep phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/grep-2.22.tar.xz
	cd $(lfs_builddir)/grep-2.22 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/grep-2.22
	$(MAKE) -C $(lfs_builddir)/grep-2.22 check
	$(MAKE) -C $(lfs_builddir)/grep-2.22 install
	rm -rf $(lfs_builddir)/grep-2.22

#################################################################
#  gzip - phase 2												#
#################################################################

gzip: grep
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: gzip phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/gzip-1.6.tar.xz
	cd $(lfs_builddir)/gzip-1.6 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/gzip-1.6
	$(MAKE) -C $(lfs_builddir)/gzip-1.6 check
	$(MAKE) -C $(lfs_builddir)/gzip-1.6 install
	rm -rf $(lfs_builddir)/gzip-1.6

#################################################################
#  m4 - phase 2												#
#################################################################

m4pkgsrc = m4-1.4.17.tar.xz
m4pkgdir = m4-1.4.17
m4: gzip
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: m4 phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/$(m4pkgsrc)
	cd $(lfs_builddir)/$(m4pkgdir) && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/$(m4pkgdir)
	$(MAKE) -C $(lfs_builddir)/$(m4pkgdir) check
	$(MAKE) -C $(lfs_builddir)/$(m4pkgdir) install
	rm -rf $(lfs_builddir)/$(m4pkgdir)

#################################################################
#  make - phase 2												#
#################################################################

makepkgsrc = make-4.1.tar.bz2
makepkgdir = make-4.1
make: m4
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: make phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/$(makepkgsrc)
	cd $(lfs_builddir)/$(makepkgdir) && ./configure --prefix=/tools --without-guile
	$(MAKE) -C $(lfs_builddir)/$(makepkgdir)
	# $(MAKE) -C $(lfs_builddir)/$(makepkgdir) check
	$(MAKE) -C $(lfs_builddir)/$(makepkgdir) install
	rm -rf $(lfs_builddir)/$(makepkgdir)

#################################################################
#  patch - phase 2												#
#################################################################

patchpkgsrc = patch-2.7.5.tar.xz
patchpkgdir = patch-2.7.5
patch: make
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: patch phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/$(patchpkgsrc)
	cd $(lfs_builddir)/$(patchpkgdir) && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/$(patchpkgdir)
	$(MAKE) -C $(lfs_builddir)/$(patchpkgdir) check
	$(MAKE) -C $(lfs_builddir)/$(patchpkgdir) install
	rm -rf $(lfs_builddir)/$(patchpkgdir)

#################################################################
#  perl - phase 2												#
#################################################################

perl: patch
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: perl phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/perl-5.22.0.tar.bz2
	cd $(lfs_builddir)/perl-5.22.0 && sh Configure -des -Dprefix=/tools -Dlibs=-lm
	$(MAKE) -C $(lfs_builddir)/perl-5.22.0
	cd $(lfs_builddir)/perl-5.22.0 && cp -v perl cpan/podlators/pod2man /tools/bin
	cd $(lfs_builddir)/perl-5.22.0 && mkdir -pv /tools/lib/perl5/5.22.0
	cd $(lfs_builddir)/perl-5.22.0 && cp -Rv lib/* /tools/lib/perl5/5.22.0
	rm -rf $(lfs_builddir)/perl-5.22.0

#################################################################
#  sed - phase 2												#
#################################################################

sedpkgsrc = sed-4.2.2.tar.bz2
sedpkgdir = sed-4.2.2
sed: perl
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: sed phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/$(sedpkgsrc)
	cd $(lfs_builddir)/$(sedpkgdir) && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/$(sedpkgdir)
	$(MAKE) -C $(lfs_builddir)/$(sedpkgdir) check
	$(MAKE) -C $(lfs_builddir)/$(sedpkgdir) install
	rm -rf $(lfs_builddir)/$(sedpkgdir)

#################################################################
#  tar - phase 2												#
#################################################################

tarpkgsrc = tar-1.28.tar.xz
tarpkgdir = tar-1.28
tar: sed
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: tar phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/$(tarpkgsrc)
	cd $(lfs_builddir)/$(tarpkgdir) && FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/$(tarpkgdir)
	$(MAKE) -C $(lfs_builddir)/$(tarpkgdir) check
	$(MAKE) -C $(lfs_builddir)/$(tarpkgdir) install
	rm -rf $(lfs_builddir)/$(tarpkgdir)

#################################################################
#  texinfo - phase 2											#
#################################################################

texinfopkgsrc = texinfo-6.0.tar.xz
texinfopkgdir = texinfo-6.0
texinfo: tar
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: texinfo phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/$(texinfopkgsrc)
	cd $(lfs_builddir)/$(texinfopkgdir) && FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/$(texinfopkgdir)
	$(MAKE) -C $(lfs_builddir)/$(texinfopkgdir) check
	$(MAKE) -C $(lfs_builddir)/$(texinfopkgdir) install
	rm -rf $(lfs_builddir)/$(texinfopkgdir)

#################################################################
#  util-linux - phase 2											#
#################################################################

ulpkgsrc = util-linux-2.27.1.tar.xz
ulpkgdir = util-linux-2.27.1
utillinux: texinfo
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: utillinux phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/$(ulpkgsrc)
	cd $(lfs_builddir)/$(ulpkgdir) && ./configure --prefix=/tools --without-python --disable-makeinstall-chown --without-systemdsystemunitdir PKG_CONFIG=""
	$(MAKE) -C $(lfs_builddir)/$(ulpkgdir)
	$(MAKE) -C $(lfs_builddir)/$(ulpkgdir) install
	rm -rf $(lfs_builddir)/$(ulpkgdir)

#################################################################
#  xz - phase 2												#
#################################################################

xzpkgsrc = xz-5.2.2.tar.xz
xzpkgdir = xz-5.2.2
xz: utillinux
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: xz phase-2"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/$(xzpkgsrc)
	cd $(lfs_builddir)/$(xzpkgdir) && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/$(xzpkgdir)
	$(MAKE) -C $(lfs_builddir)/$(xzpkgdir) check
	$(MAKE) -C $(lfs_builddir)/$(xzpkgdir) install
	rm -rf $(lfs_builddir)/$(xzpkgdir)

#################################################################
#  finalize_p2: phase 2											#
#################################################################

finalize_p2: xz
	chown -R root:root $(lfs_home)/tools

#################################################################
#  Start system install											#
#################################################################

build_glibc_full: finalize_p2
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: glibc full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/glibc-2.23.tar.xz
	cd $(lfs_builddir)/glibc-2.23 && patch -Np1 -i $(lfs_sources)/glibc-2.23-fhs-1.patch
	cd $(lfs_builddir)/glibc-2.23 && patch -Np1 -i $(lfs_sources)/glibc-2.23-upstream_fixes-1.patch
	mkdir -v $(lfs_builddir)/glibc-build
	cd $(lfs_builddir)/glibc-build && $(lfs_builddir)/glibc-2.23/configure --prefix=/tools --disable-profile --enable-kernel=2.6.3 --enable-obsolete-rpc
	$(MAKE) -C $(lfs_builddir)/glibc-build
	# $(MAKE) -C $(lfs_builddir)/glibc-build -k check
	rm -rf $(lfs_builddir)/glibc-2.23
	rm -rf $(lfs_builddir)/glibc-build

adjust_toolchain: build_glibc_full
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: adjust_toolchain full"
	@echo "###################################################"
	/bin/bash /mnt/adjust_toolchain.sh

build_binutils: adjust_toolchain
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: binutils full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/binutils-2.25.1.tar.bz2
	mkdir -v $(lfs_builddir)/binutils-build
	cd $(lfs_builddir)/binutils-build && $(lfs_builddir)/binutils-2.25.1/configure --prefix=/tools --enable-shared --disable-werror
	$(MAKE) -C $(lfs_builddir)/binutils-build tooldir=/tools
	$(MAKE) -C $(lfs_builddir)/binutils-build check
	$(MAKE) -C $(lfs_builddir)/binutils-build tooldir=/tools install
	rm -rf $(lfs_builddir)/binutils-build
	rm -rf $(lfs_builddir)/binutils-2.25.1

build_gmp: build_binutils
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: gmp full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/gmp-6.1.0.tar.xz
	cd $(lfs_builddir)/gmp-6.1.0 && ./configure --prefix=/tools --enable-cxx --disable-static --docdir=/usr/share/doc/gmp-6.1.0
	$(MAKE) -C $(lfs_builddir)/gmp-6.1.0
	$(MAKE) -C $(lfs_builddir)/gmp-6.1.0 html
	$(MAKE) -C $(lfs_builddir)/gmp-6.1.0 check
	$(MAKE) -C $(lfs_builddir)/gmp-6.1.0 install
	$(MAKE) -C $(lfs_builddir)/gmp-6.1.0 install-html
	rm -rf $(lfs_builddir)/gmp-6.1.0

build_mpfr: build_gmp
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: mpfr full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/mpfr-3.1.4.tar.xz
	cd $(lfs_builddir)/mpfr-3.1.4 && patch -Np1 -i $(lfs_sources)/mpfr-3.1.4-upstream_fixes-1.patch
	cd $(lfs_builddir)/mpfr-3.1.4 && ./configure --prefix=/tools --disable-static --enable-thread-safe --docdir=/usr/share/doc/mpfr-3.1.4
	$(MAKE) -C $(lfs_builddir)/mpfr-3.1.4
	$(MAKE) -C $(lfs_builddir)/mpfr-3.1.4 html
	$(MAKE) -C $(lfs_builddir)/mpfr-3.1.4 check
	$(MAKE) -C $(lfs_builddir)/mpfr-3.1.4 install
	$(MAKE) -C $(lfs_builddir)/mpfr-3.1.4 install-html
	rm -rf $(lfs_builddir)/mpfr-3.1.4

build_mpc: build_mpfr
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: mpc full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/mpc-1.0.3.tar.gz
	cd $(lfs_builddir)/mpc-1.0.3 && ./configure --prefix=/tools --disable-static --docdir=/usr/share/doc/mpc-1.0.3
	$(MAKE) -C $(lfs_builddir)/mpc-1.0.3
	$(MAKE) -C $(lfs_builddir)/mpc-1.0.3 html
	$(MAKE) -C $(lfs_builddir)/mpc-1.0.3 check
	$(MAKE) -C $(lfs_builddir)/mpc-1.0.3 install
	$(MAKE) -C $(lfs_builddir)/mpc-1.0.3 install-html
	rm -rf $(lfs_builddir)/mpc-1.0.3

build_file: build_mpc
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: file full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -zxf $(lfs_sources)/file-5.25.tar.gz
	cd $(lfs_builddir)/file-5.25 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/file-5.25
	$(MAKE) -C $(lfs_builddir)/file-5.25 check
	$(MAKE) -C $(lfs_builddir)/file-5.25 install
	rm -rf $(lfs_builddir)/file-5.25

build_zlib: build_file
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: zlib full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -xf $(lfs_sources)/zlib-1.2.8.tar.xz
	cd $(lfs_builddir)/zlib-1.2.8 && ./configure --prefix=/tools
	$(MAKE) -C $(lfs_builddir)/zlib-1.2.8
	$(MAKE) -C $(lfs_builddir)/zlib-1.2.8 check
	$(MAKE) -C $(lfs_builddir)/zlib-1.2.8 install
	rm -rf $(lfs_builddir)/zlib-1.2.8

build_gcc_full: build_zlib
	@echo "###################################################"
	@echo " LFS_BUILD_RUN: gcc-full"
	@echo "###################################################"
	tar -C $(lfs_builddir) -jxf $(lfs_sources)/gcc-6.1.0.tar.bz2
	mkdir -v $(lfs_builddir)/gcc-build
	cd $(lfs_builddir)/gcc-build && SED=sed $(lfs_builddir)/gcc-6.1.0/configure --prefix=/tools --enable-languages=c,c++ --disable-multilib --disable-bootstrap --with-system-zlib
	$(MAKE) -C $(lfs_builddir)/gcc-build
	ulimit -s 32768
	$(MAKE) -C $(lfs_builddir)/gcc-build -k check
	rm -rf $(lfs_builddir)/gcc-build
	rm -rf $(lfs_builddir)/gcc-6.1.0
