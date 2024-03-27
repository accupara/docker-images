ROOT_PATH=/tmp/src

CMAKE_VER?=3.27.9
BOOST_VER?=1_82_0

it:
	docker run \
		--rm -it \
		-v $(shell readlink -f .):${ROOT_PATH} \
		-w ${ROOT_PATH} \
		accupara/qt5:ubuntu_2204 \
		bash

clean_deps:
	-sudo find ${ROOT_PATH}/deps -delete

prep:
	${MAKE} -f build.mk prep1
	${MAKE} -f build.mk prep2
	${MAKE} -f build.mk prep3
	${MAKE} -f build.mk prep4

prep1:
	sudo apt-get update
	sudo apt-get install -y \
		catch2 \
		cmake \
		extra-cmake-modules \
		g++ \
		gcc \
		gtk-doc-tools \
		libcairo2-dev \
		libeigen3-dev \
		libexiv2-dev \
		libfftw3-dev \
		libfreetype6-dev \
		libglib2.0-dev \
		libgsl-dev \
		libharfbuzz-dev \
		libjpeg-turbo8-dev \
		libjpeg-turbo-progs \
		libkdecorations2-dev \
		libkf5completion-dev \
		libkf5config-dev \
		libkf5coreaddons-dev \
		libkf5crash-dev \
		libkf5guiaddons-dev \
		libkf5i18n-dev \
		libkf5itemmodels-dev \
		libkf5itemviews-dev \
		libkf5kdcraw-dev \
		libkf5widgetsaddons-dev \
		libkf5windowsystem-dev \
		liblcms2-dev \
		libmypaint-dev \
		libopenexr-dev \
		libopenjp2-7-dev \
		libopenjp2-tools \
		libquazip5-dev \
		libqt5quick5 \
		libqt5quickwidgets5 \
		libqt5svg5-dev \
		libqt5x11extras5-dev \
		libtiff-dev \
		libwebp-dev \
		meson \
		ninja-build \
		pkg-config \
		pyqt5-dev \
		python3-pip \
		python3-qtpy \
		qtquickcontrols2-5-dev \
		ragel \
		sip-dev \
		ruby-sass \
		xorg-dev \
	&& sudo update-alternatives --install /usr/local/bin/python python /usr/bin/python3 20 \
	&& sudo python3 -m pip install --upgrade pip \
	&& sudo python3 -m pip install numpy

prep2:
	${MAKE} -f build.mk prep2_cmake
	${MAKE} -f build.mk prep2_boost

prep2_cmake:
	mkdir -p ${ROOT_PATH}/deps
	wget -q -O ${ROOT_PATH}/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
	&& chmod +x ${ROOT_PATH}/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh \
	&& sudo ${ROOT_PATH}/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr

prep2_boost:
	mkdir -p ${ROOT_PATH}/deps
	wget -q -O ${ROOT_PATH}/deps/boost_${BOOST_VER}.tar.gz https://downloads.sourceforge.net/project/boost/boost/$$(echo ${BOOST_VER} | sed 's/_/./g')/boost_${BOOST_VER}.tar.gz >/dev/null \
	&& sudo tar -C ${ROOT_PATH}/deps -xf ${ROOT_PATH}/deps/boost_${BOOST_VER}.tar.gz \
	&& sudo chown -R admin:admin ${ROOT_PATH}/deps/boost_${BOOST_VER} \
	&& cd ${ROOT_PATH}/deps/boost_${BOOST_VER} \
	&& ./bootstrap.sh --prefix=/usr \
	&& ./b2 \
	&& sudo ./b2 install

prep3:
	mkdir -p ${ROOT_PATH}/deps
	-for i in immer zug lager faber ; do \
		sudo find ${ROOT_PATH}/deps/$${i} -delete ; \
	done
# Download and install immer, zug, lager
	git -C ${ROOT_PATH}/deps clone https://github.com/arximboldi/immer.git immer
	git -C ${ROOT_PATH}/deps clone https://github.com/arximboldi/zug.git zug
	git -C ${ROOT_PATH}/deps clone https://github.com/arximboldi/lager.git lager
	set -e ; \
	for i in immer zug lager ; do \
        cd ${ROOT_PATH}/deps/$${i} && mkdir build && cd build && cmake .. && sudo make install ; \
    done
# Install faber for boost.python
	git -C ${ROOT_PATH}/deps clone https://github.com/stefanseefeld/faber.git faber \
 	&& cd ${ROOT_PATH}/deps/faber \
	&& sudo python3 setup.py install
#  harfbuzz
	git -C ${ROOT_PATH}/deps clone https://github.com/harfbuzz/harfbuzz.git harfbuzz
	cd ${ROOT_PATH}/deps/harfbuzz ; meson build
	cd ${ROOT_PATH}/deps/harfbuzz ; meson test -Cbuild
	cd ${ROOT_PATH}/deps/harfbuzz ; meson install -Cbuild
# libunibreak
	git -C ${ROOT_PATH}/deps clone https://github.com/adah1972/libunibreak.git libunibreak
	cd ${ROOT_PATH}/deps/libunibreak ; ./autogen.sh
	make -C ${ROOT_PATH}/deps/libunibreak -j `nproc`
	sudo make -C ${ROOT_PATH}/deps/libunibreak install

prep4:
	mkdir -p ${ROOT_PATH}/deps
	echo "Nothing else remains to be built for deps"
