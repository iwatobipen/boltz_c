FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y \
    wget \
    git \
    vim \
    sudo \
    build-essential \
    bison \
    python3.10 \
    python3-pip \
    flex

RUN pip install boltz
#RUN boltz --help
WORKDIR /opt
