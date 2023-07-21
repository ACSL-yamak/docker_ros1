#! /bin/sh
if [ -z $ssh_setuped ] ; then
	echo "root:root" | chpasswd
	echo "PermitRootLogin yes" >>/etc/ssh/sshd_config
	# echo "PasswordAuthentication yes" >>/etc/ssh/sshd_config
	echo "Port 3222">> /etc/ssh/sshd_config
	mkdir /run/sshd
	echo "ssh_setuped=true">>$profile
fi
/usr/sbin/sshd -D &
