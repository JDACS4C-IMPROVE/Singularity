FROM ubuntu:22.10

RUN apt clean && apt update -y && apt upgrade -y
RUN apt-get install -y \
    make \
    wget
WORKDIR /tmp
RUN wget https://github.com/apptainer/apptainer/releases/download/v1.1.3/apptainer_1.1.3_amd64.deb && apt-get install -y ./apptainer_1.1.3_amd64.deb
# RUN wget https://github.com/apptainer/apptainer/releases/download/v1.1.3/apptainer-suid_1.1.3_amd64.deb && dpkg -i ./apptainer-suid_1.1.3_amd64.deb  