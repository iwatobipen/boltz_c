FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y \
    wget \
    git \
    vim \
    sudo \
    build-essential \
    bison \
    python3.11 \
    python3-pip \
    flex
#RUN pip3 install boltz==0.3.2

RUN git clone https://github.com/jwohlwend/boltz.git && \
cd boltz && \
touch setup.cfg && \
pip install -e .
WORKDIR /opt
