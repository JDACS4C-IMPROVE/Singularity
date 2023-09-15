FROM ubuntu:20.04


RUN apt-get -y update

ENV LANG=en_US.UTF-8
ENV LANGUAGE=
ENV LC_CTYPE="en_US.UTF-8"
ENV LC_NUMERIC="en_US.UTF-8"
ENV LC_TIME="en_US.UTF-8"
ENV LC_COLLATE="en_US.UTF-8"
ENV LC_MONETARY="en_US.UTF-8"
ENV LC_MESSAGES="en_US.UTF-8"
ENV LC_PAPER="en_US.UTF-8"
ENV LC_NAME="en_US.UTF-8"
ENV LC_ADDRESS="en_US.UTF-8"
ENV LC_TELEPHONE="en_US.UTF-8"
ENV LC_MEASUREMENT="en_US.UTF-8"
ENV LC_IDENTIFICATION="en_US.UTF-8"
ENV LC_ALL=
ENV PATH=/usr/games:$PATH



RUN apt-get -y install software-properties-common
    # add-apt-repository main
    # add-apt-repository universe
    # add-apt-repository restricted
    # add-apt-repository multiverse 

RUN add-apt-repository main 
RUN add-apt-repository universe 
RUN add-apt-repository restricted 
RUN add-apt-repository multiverse

RUN    apt-get install -y build-essential cmake unzip pkg-config
RUN    apt-get install -y libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
RUN    apt-get install -y libjpeg-dev libpng-dev libtiff-dev
RUN    apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
RUN    apt-get install -y libxvidcore-dev libx264-dev
RUN    apt-get install -y libgtk-3-dev
RUN    apt-get install -y libopenblas-dev libatlas-base-dev liblapack-dev gfortran
RUN    apt-get install -y libhdf5-serial-dev graphviz
RUN    apt-get install -y python3-dev python3-tk python-imaging-tk
RUN    apt-get install -y linux-source linux-headers-generic


RUN    apt-get install -y sudo \
    wget \
    python3.8




