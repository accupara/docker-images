#!/usr/bin/make -f

build: build-stamp

build-stamp:
	dh_testdir
	touch build-stamp

clean:
	dh_testdir
	dh_testroot
	rm -f build-stamp
	dh_clean

install: build
	dh_testdir
	dh_testroot
	dh_clean -k
	dh_installdirs
	dh_installkpatches

# Build architecture-independent files here.
binary-indep: install
	dh_testdir
	dh_testroot
	dh_installdocs
	dh_installchangelogs
	dh_compress
	dh_fixperms
	dh_installdeb
	dh_gencontrol
	dh_md5sums
	dh_builddeb

binary-arch: binary-indep

binary: binary-indep binary-arch
.PHONY: build clean binary-indep binary-arch binary install
