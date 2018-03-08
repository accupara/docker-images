# Copyright (c) 2016-2018 Accupara Inc. All rights reserved

build: dist/build

dist/build: build.spec build.py
	pyinstaller build.spec

build.spec:
	pyi-makespec --onefile build.py

clean:
	rm -rf build dist __pycache__

in_docker:
	docker run --rm -it \
		-v `pwd`:/tmp/src \
		accupara/pyinstaller:centos_6 \
		make -C /tmp/src $(TARGET)
