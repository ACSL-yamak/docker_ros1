FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
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

# RUN apt -y update && apt -y upgrade && apt -y install \
# 	git \
# 	&& apt clean \
# 	&& rm -rf /var/lib/apt/lists/* 


#####################################
# Install of ROS melodic

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
&& curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - 

RUN apt update -y \
&& apt install -y \
	ros-melodic-desktop-full \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* 

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc 

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
	gnome-terminal \
	python-catkin-tools\
&& pip3 install -U setuptools \
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

RUN colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release