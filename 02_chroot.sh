#!/bin/bash 

# apt-get install 
apt-cache search linux-image
apt-get update && \
apt-get install --no-install-recommends --yes --force-yes \
	linux-image-586 live-boot systemd-sysv \
	network-manager net-tools wireless-tools wpagui \
	tcpdump wget openssh-server \
	blackbox xserver-xorg-core xserver-xorg xinit xterm \
	pciutils usbutils gparted ntfs-3g hfsprogs rsync dosfstools \
	syslinux partclone nano pv \
	vim git \
	rtorrent iceweasel chntpw && \
apt-get clean
echo "Sole Install soft"

