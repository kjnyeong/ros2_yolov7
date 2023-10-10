
# amd || arm 둘 다 사용 가능
FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

# # arm
# FROM arm64v8/ubuntu:20.04

# ENV DEBIAN_FRONTEND=noninteractive

# ROS2 설치
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8

RUN apt update && \
    apt install -y curl gnupg2 lsb-release && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    apt update && \
    apt install -y  -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" keyboard-configuration && \
    apt install -y ros-foxy-desktop && \
    apt install -y python3-colcon-common-extensions && \
    apt install -y git && \
    apt install -y xterm && \
    apt install -y wget && \
    apt install -y pciutils && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*
RUN echo "source /opt/ros/foxy/setup.bash" >> /root/.bashrc

RUN apt-get update && apt-get install wget -yq
RUN apt-get install -y apt-utils
RUN apt-get install build-essential g++ gcc -y
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install libgl1-mesa-glx libglib2.0-0 -y
RUN apt-get install openmpi-bin openmpi-common libopenmpi-dev libgtk2.0-dev git -y

RUN apt -y install software-properties-common
RUN apt-get install -y python3-pip 
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt -y install python3.8
# amd arm 설치법
RUN pip3 install torch==1.10.1 torchvision==0.11.2 torchaudio==0.10.1 
RUN pip3 install tqdm
RUN pip3 install opencv-python 
RUN pip3 install numpy 
RUN pip3 install pyrealsense2 
RUN pip3 install rospkg
RUN pip3 install pandas
RUN pip3 install seaborn
RUN pip3 install scipy
RUN pip3 install onnx
RUN pip3 install thop
RUN pip3 install torchpack
RUN pip3 install pytest

# 폴더 만들기 docker_ws , shared_ws
WORKDIR /home/docker_ws
WORKDIR /home/shared_ws

# 현재 경로의 my_package 폴더를 /home/docker_ws 내부에 복사
COPY ros2_yolov7 ./ros2_yolov7




