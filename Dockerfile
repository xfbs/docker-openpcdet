FROM nvidia/cuda:10.1-cudnn7-devel

RUN apt update

RUN apt install -y python3 python3-pip apt-transport-https ca-certificates gnupg software-properties-common wget git ninja-build libboost-dev build-essential

# Install PyTorch
RUN pip3 install torch==1.5 torchvision==0.6.0

# Install CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - > /etc/apt/trusted.gpg.d/kitware.gpg
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
RUN apt-get update && apt install -y cmake

# Install spconv
COPY spconv /tmp/spconv
WORKDIR /tmp/spconv
RUN python3 setup.py bdist_wheel
RUN pip3 install dist/*.whl

# Install LLVM 10
WORKDIR /tmp
RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh 10

# OpenPCDet dependencies fail to install unless LLVM 10 exists on the system
# and there is a llvm-config binary available, so we have to symlink it here.
RUN ln -s /usr/bin/llvm-config-10 /usr/bin/llvm-config

ARG TORCH_CUDA_ARCH_LIST="5.2 6.0 6.1 7.0 7.5+PTX"

# Install OpenPCDet
COPY OpenPCDet /tmp/OpenPCDet
WORKDIR /tmp/OpenPCDet
RUN pip3 install -r requirements.txt
RUN python3 setup.py develop
