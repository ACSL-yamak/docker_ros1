FROM ubuntu:20.04 AS base_img
ARG DEBIAN_FRONTEND=noninteractive
#####################################
# Installation of frequently used tools
RUN apt -y update && apt -y upgrade && apt -y install \
	sudo \
	nano \
	git \
	openssh-server \
	xserver-xorg \
	tzdata \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& ssh-keygen -A \
	&& mkdir -p /run/sshd \
	&& echo "Port 3222" >> /etc/ssh/sshd_config \
	&& cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# RUN apt -y update && apt -y upgrade && apt -y install \
# 	git \
# 	&& apt clean \
# 	&& rm -rf /var/lib/apt/lists/* \

FROM base_img AS ros_noetic
ARG DEBIAN_FRONTEND=noninteractive
#####################################
COPY ros_noetic_install.sh /root/ros_noetic_install.sh
RUN apt -y update && apt -y upgrade \
	&& /root/ros_noetic_install.sh && rm /root/ros_noetic_install.sh \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* 

