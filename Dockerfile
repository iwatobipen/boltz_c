FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04


RUN apt-get update && apt-get install -y \
    wget \
    git \
    vim \
    sudo \
    build-essential
WORKDIR /opt

RUN wget https://github.com/conda-forge/miniforge/releases/download/24.3.0-0/Mambaforge-24.3.0-0-Linux-x86_64.sh && \
    git clone https://github.com/jwohlwend/boltz.git && \
    sh Mambaforge-24.3.0-0-Linux-x86_64.sh -b -p /opt/Mambaforge && \
    rm -r Mambaforge-24.3.0-0-Linux-x86_64.sh

ENV PATH /opt/Mambaforge/bin:$PATH
WORKDIR /opt/boltz
RUN mamba create -n boltz python=3.10 -y && \
    conda init
SHELL ["conda", "run", "-n", "boltz", "/bin/bash", "-c"]

RUN touch setup.cfg && \
    conda clean --all -y && \ 
    pip cache purge && \
    pip install -e . && \
    echo "conda activate boltz" >> ~/.bashrc


ENV PATH /opt/Mambaforge/envs/boltz/bin:$PATH
#RUN git clone https://github.com/jwohlwend/boltz.git && \
#cd boltz && \
#touch setup.cfg && \
#pip install -e .

