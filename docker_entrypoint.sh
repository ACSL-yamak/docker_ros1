#!/bin/sh
echo "root:root" | chpasswd
echo "PermitRootLogin yes" >>/etc/ssh/sshd_config
# echo "PasswordAuthentication yes" >>/etc/ssh/sshd_config
/usr/sbin/sshd -D &

# 
exec /bin/bash

# stopping
apt-get clean && apt clean\
&& rm -rf /var/lib/apt/lists/*
