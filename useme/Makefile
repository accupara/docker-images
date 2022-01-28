# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

IMAGE=accupara/pyinstaller:ubuntu_1604

build: dist/build

dist/build: build.spec build.py
	pyinstaller build.spec

build.spec:
	pyi-makespec --onefile build.py

clean:
	rm -rf build dist __pycache__

rebuild:
	$(MAKE) clean
	$(MAKE) build

in_docker:
	docker run --rm -it \
		-v `pwd`:/tmp/src \
		$(IMAGE) \
		make -C /tmp/src $(TARGET)
