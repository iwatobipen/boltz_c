FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04



RUN apt-get update && apt-get install -y \
    wget \
    git \
    vim \
    sudo \
    build-essential
WORKDIR /opt

RUN wget https://github.com/conda-forge/miniforge/releases/download/24.11.3-2/Miniforge3-24.11.3-2-Linux-x86_64.sh && \
    git clone https://github.com/jwohlwend/boltz.git && \
    sh Miniforge3-24.11.3-2-Linux-x86_64.sh -b -p /opt/Miniforge && \    
    rm -r Miniforge3-24.11.3-2-Linux-x86_64.sh
    
ENV PATH /opt/Miniforge/bin:$PATH
WORKDIR /opt/boltz
RUN conda create -n boltz python=3.11 -y && \
    conda init
SHELL ["conda", "run", "-n", "boltz", "/bin/bash", "-c"]

RUN touch setup.cfg && \
    conda clean --all -y && \ 
    pip cache purge && \
    pip install -e . && \
    echo "conda activate boltz" >> ~/.bashrc

ENV PATH /opt/Miniforge/envs/boltz/bin:$PATH


