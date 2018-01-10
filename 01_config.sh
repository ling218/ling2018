#!/bin/bash

# start atp,mkdir,debootstrap
# *apt-get 
apt-get install -y \
	debootstrap \
	syslinux \
	isolinux \
	squashfs-tools \
	genisoimage \
	memtest+86+ \
	rsync 
# *mkdir 
mkdir $HOME/live_sole
# *debootstrap
debootstrap \
	--arch=amd64 \
	--variant=minbase \
	stretch $HOME/live_sole/chroot \
	http://ftp.cn.debian.org/debian/
# set /etc/*
echo "sole" > /$HOME/live_sole/chroot/etc/hostname
# echo "" >> /$HOME/live_sole/chroot/etc/
# echo "Sole GUN/Linux 2018 \n \l"

# chroot 
cp 02_chroot.sh /$HOME/live_sole/chroot/
chroot $HOME/live_sole/chroot/
