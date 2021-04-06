# Docker OpenPCDet

This is a docker container with OpenPCDet installed. To build or use this, you
need to install docker, as well as nvidia-docker to pass the GPU through to the
container.

It is available on the Docker hub as `xfbs/openpcdet`. You can use docker pull to fetch it for use on your machine.

    docker pull xfbs/openpcdet

## Setup

Install docker as per the instructions on [docs.docker.com](https://docs.docker.com/engine/install/ubuntu/). Install nvidia-docker as per the instructions on [docs.nvidia.com](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker). Make sure that your user is able to use docker by adding it to the `docker` group, if not already there:

    useradd $USER docker

Reboot your machine for the change to take effect (or restart your X server). Ensure that you are in the docker group by running the `groups` command (should show `docker`).

Make sure you have the NVidia drivers installed from [developer.nvidia.com](https://developer.nvidia.com/cuda-downloads). If you use Ubuntu, install the Deb version of them. Reboot your system to make sure you are using the NVidia drivers. You need to use at least version 10.1.

You need to figure out the CUDA compute capability of your GPU. You can use [this chart](https://developer.nvidia.com/cuda-gpus) to look it up. See also [this section](https://pytorch.org/docs/stable/cpp_extension.html?highlight=cudaextension#torch.utils.cpp_extension.CUDAExtension) of the PyTorch documentation.

## Building

Before compiling, make sure that you have checked out the Git repository and submodules recursively. To ensure that is the case, run this.

    git submodule update --init --recursive

To build the container, you can run the Docker build command from this repository.

    docker build . -t openpcdet

You might want to check what CUDA compute capability you require. That is, the CUDA extensions in OpenPCDet are normally built for the GPU detected during installation, however for this Docker container, the GPU is not available during build time. You can override the CUDA compute capabilities using the `--build-arg TORCH_CUDA_ARCH_LIST=XYZ` flag.

## License

MIT.
