#!/bin/bash
set -e

# http://wiki.ros.org/noetic/Installation/Ubuntu
# https://qiita.com/harumo11/items/ae604ba2e17ffda529c2
sudo apt -y update
sudo apt install -y gnupg

# Setup your sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Set up your keys
sudo apt -y install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Installation
sudo apt -y update
sudo apt -y install ros-noetic-desktop-full

# Environment setup
source /opt/ros/noetic/setup.bash

# (optional)
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Dependencies for building packages
sudo apt -y install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
sudo apt -y install python3-rosdep
sudo rosdep init
rosdep update

# catkin install
sudo apt -y install python3-catkin-tools

# catkin build

# source /opt/ros/noetic/setup.bash
# mkdir -p ~/catkin_ws/src
# cd ~/catkin_ws
# catkin build
# source devel/setup.bash

# END
sudo apt -y clean
