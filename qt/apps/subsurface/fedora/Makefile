# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
IMGTAG?=accupara/subsurface
IMGVER?=fedora

GITROOT := $(shell git rev-parse --show-toplevel)
GIT_URL=$(shell git remote -v | grep fetch | awk '{print $$2}' | sed -s 's/git@github.com:/https:\/\/github.com\//g' | sed -s 's/.git$$//')
mkfile_local := $(abspath $(lastword $(MAKEFILE_LIST)))
gitroot_regex := $(shell echo $(GITROOT) | sed -s 's/\//\\\//g')
mkfile_git := "$(GIT_URL)/tree/master$(shell echo "$(mkfile_local)" | sed -s 's/$(gitroot_regex)//g')"
dockerfile_git := $(shell bash -c "echo $$(dirname $(mkfile_git))/Dockerfile")

include $(shell git rev-parse --show-toplevel)/Makefile.build
