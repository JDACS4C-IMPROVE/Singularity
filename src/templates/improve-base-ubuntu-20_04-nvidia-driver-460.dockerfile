Bootstrap: debootstrap
OSVersion: focal
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%post
    apt-get -y install software-properties-common
    add-apt-repository main
    add-apt-repository universe
    add-apt-repository restricted
    add-apt-repository multiverse
# The next command seems to fail because it is expecting user input [return]
    add-apt-repository ppa:graphics-drivers/ppa
    add-apt-repository ppa:graphics-drivers

    apt-get -y update
    apt-get -y upgrade

    apt-get install apt-utils
    apt-get install -y locales
    locale-gen en_US.UTF-8
    update-locale
    locale

    apt-get install -y ubuntu-drivers-common
    apt-get install -y build-essential cmake unzip pkg-config
    apt-get install -y libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
    apt-get install -y libjpeg-dev libpng-dev libtiff-dev
    apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
    apt-get install -y libxvidcore-dev libx264-dev
    apt-get install -y libgtk-3-dev
    apt-get install -y libopenblas-dev libatlas-base-dev liblapack-dev gfortran
    apt-get install -y libhdf5-serial-dev graphviz
    apt-get install -y python3-dev python3-tk python-imaging-tk
    apt-get install -y linux-source linux-headers-generic


    apt-get install -y sudo
    apt-get install -y wget
#    apt-get install -y python3.8

# Add nvidia driver. This should be =< version as that of the native host
# the following command also fails because it is s looking for user input
    printf '31\n1\n' | apt-get install -y nvidia-driver-460    

%environment
#    export LANG=en_US.UTF-8
#    export LANGUAGE=
#    export LC_CTYPE="en_US.UTF-8"
#    export LC_NUMERIC="en_US.UTF-8"
#    export LC_TIME="en_US.UTF-8"
#    export LC_COLLATE="en_US.UTF-8"
#    export LC_MONETARY="en_US.UTF-8"
#    export LC_MESSAGES="en_US.UTF-8"
#    export LC_PAPER="en_US.UTF-8"
#    export LC_NAME="en_US.UTF-8"
#    export LC_ADDRESS="en_US.UTF-8"
#    export LC_TELEPHONE="en_US.UTF-8"
#    export LC_MEASUREMENT="en_US.UTF-8"
#    export LC_IDENTIFICATION="en_US.UTF-8"
#    export LC_ALL=
#    export PATH=/usr/games:$PATH


