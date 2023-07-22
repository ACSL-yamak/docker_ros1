FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
#####################################
# NVIDIA driver setup
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        libxau6 libxau6:i386 \
        libxdmcp6 libxdmcp6:i386 \
        libxcb1 libxcb1:i386 \
        libxext6 libxext6:i386 \
        libx11-6 libx11-6:i386 && \
    rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
        ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64

#####################################
# Installation of frequently used tools
RUN apt update -y \
&& apt upgrade -y \
&& apt install -y\
  curl \
  git \
  gnupg \
  nano \
  openssh-server \
  sudo \
  tzdata \
  udev \
  xserver-xorg \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* \
&& ssh-keygen -A \
&& mkdir -p /run/sshd \
&& cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#####################################
# Install of ROS melodic

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
&& curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - 

RUN apt update -y \
&& apt install -y \
	ros-melodic-desktop-full \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* 

RUN apt update -y \
&& apt install -y \
	python-rosdep \
	python-rosinstall \
	python-rosinstall-generator \
	python-wstool \
	build-essential \
	python-rosdep \
	python-catkin-tools \
&& rosdep init \
&& rosdep update \
&& apt clean \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* 

#####################################
RUN  apt update -y \
&& apt install -y \
	python-catkin-pkg \
	python-rosdep \
	ros-melodic-catkin \
	python3-pip \
	python3-colcon-common-extensions \
	python3-setuptools \
	python3-vcstool \
	xfce4-terminal\
	python-catkin-tools\
&& pip3 install -U setuptools \
&& apt clean \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* 


##########################################
# Setup CUDA 10.0
RUN  apt update -y \
&& apt install -y \
	software-properties-common\
&& pip3 install -U setuptools \
&& apt clean \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* 


RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub \
&& apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub 
RUN apt-get update \
&& apt-get -y install cuda-10.0 \
&& apt clean \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

##########################################
# Install of Autoware Ai

RUN cd /root \
&& mkdir -p autoware.ai/src \
&& cd autoware.ai \
&& wget -O autoware.ai.repos "https://raw.githubusercontent.com/autowarefoundation/autoware_ai/1.14.0/autoware.ai.repos" \
&& vcs import src < autoware.ai.repos \
&& apt update -y \
&& apt install -y \
&& rosdep update --include-eol-distros\
&& rosdep install -y --from-paths src --ignore-src --rosdistro melodic \
&& apt clean \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* 

SHELL ["/bin/bash","-c"]
RUN export PATH=/usr/local/cuda/bin${PATH:+:${PATH}} \
&&   export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} \
&& source /opt/ros/melodic/setup.bash \
&& cd /root/autoware.ai \
# && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release
&& AUTOWARE_COMPILE_WITH_CUDA=1 colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release



##################################
# Sample of install 

# RUN apt update -y \
# && apt install -y\
# # <Package>
# && apt clean \
# && rm -rf /var/lib/apt/lists/* 