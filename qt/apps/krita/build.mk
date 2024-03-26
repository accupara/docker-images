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

clean_prep:
	-find ${ROOT_PATH}/deps -delete
	${MAKE} -f build.mk prep

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
		libgsl-dev \
		libkdecorations2-dev \
		libkf5completion-dev \
		libkf5config-dev \
		libkf5coreaddons-dev \
		libkf5crash-dev \
		libkf5guiaddons-dev \
		libkf5i18n-dev \
		libkf5itemmodels-dev \
		libkf5itemviews-dev \
		libqt5quick5 \
		libqt5quickwidgets5 \
		libkf5widgetsaddons-dev \
		libkf5windowsystem-dev \
		libqt5svg5-dev \
		libqt5x11extras5-dev \
		libwebp-dev \
		ninja-build \
		pyqt5-dev \
		python3-pip \
		python3-qtpy \
		qtquickcontrols2-5-dev \
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

# Download and install immer, zug, lager
# Install faber for boost.python
prep3:
	mkdir -p ${ROOT_PATH}/deps
	for i in immer zug lager faber ; do \
		sudo find ${ROOT_PATH}/deps/$${i} -delete ; \
	done
	git -C ${ROOT_PATH}/deps clone https://github.com/arximboldi/immer.git immer
	git -C ${ROOT_PATH}/deps clone https://github.com/arximboldi/zug.git zug
	git -C ${ROOT_PATH}/deps clone https://github.com/arximboldi/lager.git lager
	set -e ; \
	for i in immer zug lager ; do \
        cd ${ROOT_PATH}/deps/$${i} && mkdir build && cd build && cmake .. && sudo make install ; \
    done
	git -C ${ROOT_PATH}/deps clone https://github.com/stefanseefeld/faber.git faber \
 	&& cd ${ROOT_PATH}/deps/faber \
	&& sudo python3 setup.py install

prep4:
	echo "Nothing here yet"