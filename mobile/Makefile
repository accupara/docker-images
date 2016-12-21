# Copyright (c) 2016 Accupara Inc. All rights reserved

# DO NOT COMPILE bb10 automatically. It requires a UI to build..
# SUBDIRS=bb10
SUBDIRS=scratchbox maemo harmattan android

include $(shell git rev-parse --show-toplevel)/Makefile.subdirs

recreate:
	$(MAKE) clean build push
