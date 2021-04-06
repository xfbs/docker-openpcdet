# Docker OpenPCDet

This is a docker container with OpenPCDet installed. To build or use this, you
need to install docker, as well as nvidia-docker to pass the GPU through to the
container.

## Setup

Install docker as per the instructions on [docs.docker.com](https://docs.docker.com/engine/install/ubuntu/). Install nvidia-docker as per the instructions on [docs.nvidia.com](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker). Make sure that your user is able to use docker by adding it to the `docker` group, if not already there:

    useradd $USER docker

Reboot your machine for the change to take effect (or restart your X server). Ensure that you are in the docker group by running the `groups` command (should show `docker`).

Make sure you have the NVidia drivers installed from [developer.nvidia.com](https://developer.nvidia.com/cuda-downloads). If you use Ubuntu, install the Deb version of them. Reboot your system to make sure you are using the NVidia drivers. You need to use at least version 10.1.

Usage:

    git submodule update --init --recursive
    docker build .
