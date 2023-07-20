#!/bin/sh
profile=/.docker_entrypoint_profile
if [ -f $profile ] ; then
	. $profile
fi
# Setup to colorize bash
if [ -z $color_bash_setuped ] ; then
	sed -i -e  "s/#force_color_prompt=yes/force_color_prompt=yes/" /root/.bashrc
	echo "color_bash_setuped=true">>$profile
fi
# Setup to custom bashrc
if [ -z $custom_bashrc_setuped ]; then
	echo "source /docker/custom_bashrc" >> /root/.bashrc 
	echo "custom_bashrc_setuped=true" >> $profile
fi
# Setup to git
if [ -z $git_setuped ]; then
	git config --global --add safe.directory /root
	echo "git_setuped=true" >> $profile
fi
cd $(dirname $0)

. /docker/run_ssh.sh # SSHを起動する場合
##################################
cd ~
echo Ready!

exec /bin/bash 

apt-get clean && apt clean\
&& rm -rf /var/lib/apt/lists/*
exit 0