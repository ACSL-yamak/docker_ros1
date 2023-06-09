FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
#####################################
# Installation of frequently used tools
RUN apt -y update && apt -y upgrade && apt -y install \
	nano \
	git \
	openssh-server \
	xserver-xorg \
	tzdata \
	curl \
	gnupg \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& ssh-keygen -A \
	&& mkdir -p /run/sshd \
	&& echo "Port 3222" >> /etc/ssh/sshd_config \
	&& cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# RUN apt -y update && apt -y upgrade && apt -y install \
# 	git \
# 	&& apt clean \
# 	&& rm -rf /var/lib/apt/lists/* 


#####################################


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

RUN apt -y update && apt -y upgrade && apt -y install \
	gnu \
&&  apt clean \
&&  rm -rf /var/lib/apt/lists/* 