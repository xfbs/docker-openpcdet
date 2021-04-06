FROM nvidia/cuda:10.1-cudnn7-devel

RUN apt update

RUN apt install -y python3 python3-pip apt-transport-https ca-certificates gnupg software-properties-common wget

# Install PyTorch
RUN pip3 install torch==1.5

# Install CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - > /etc/apt/trusted.gpg.d/kitware.gpg
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
RUN apt-get update && apt install -y cmake libboost-dev build-essential

# Install spconv
COPY spconv /tmp/spconv
WORKDIR /tmp/spconv
RUN python3 setup.py bdist_wheel
RUN pip3 install dist/*.whl
