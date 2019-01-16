# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/debian:9
MAINTAINER Crave.io Inc. "contact@crave.io"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN sudo apt-get update --fix-missing && sudo apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN sudo wget --quiet https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    sudo /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    sudo rm ~/anaconda.sh && \
    sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN sudo apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    sudo dpkg -i tini.deb && \
    rm tini.deb && \
    sudo apt-get clean

RUN sudo /opt/conda/bin/conda update -n base conda
RUN sudo apt-get update && sudo apt-get install -y libgtk2.0-dev python3-pip && \
   sudo rm -rf /var/lib/apt/lists/* && \
   sudo /opt/conda/bin/conda install jupyter -y && \
   sudo /opt/conda/bin/conda install -c menpo opencv3 -y && \
   sudo /opt/conda/bin/conda install numpy pandas scikit-learn matplotlib seaborn pyyaml h5py -y && \
   sudo /opt/conda/bin/conda install tensorflow keras -y && \
   sudo /opt/conda/bin/conda upgrade dask
