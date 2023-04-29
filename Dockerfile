FROM nvidia/cuda:11.6.0-cudnn8-runtime-ubuntu20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libgl1 \
  python3.9 \
  python3-pip \
  git \
  && rm -rf /var/lib/apt/lists/*

ADD requirements.txt .
RUN python3.9 -m pip install --upgrade pip && python3.9 -m pip install -r requirements.txt
RUN git clone https://github.com/ai-forever/ghost.git
WORKDIR /ghost

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libglib2.0-0 \
  wget \
  ffmpeg \
  && rm -rf /var/lib/apt/lists/*

RUN sh download_models.sh