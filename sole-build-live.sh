#!/bin/bash

 ##########################
 # system sole linux 2017 #
 # desktop xfce           #
 # time 2017.12.24        #
 # gouxiaohui             #
 ##########################

# apt install build 
# apt-get update
apt-get install -y git wget live-build cdebootstrap

# git clone
git clone git://git.kali.org/live-build-config.git
cd live-build-config

# start config
cat << EOF > kali-config/variant-xfce/package-lists/kali.list.chroot
kali-linux
kali-desktop-live
kali-desktop-xfce
# kali-linux-top10
openssh-server
# ibus
# ibus-pinyin
EOF

cat << EOF > kali-config/common/includes.binary/isolinux/install.cfg
label install
	menu label ^Install Automated
	linux /install/vmlinuz
	initrd /install/initrd.gz
	append vga=788 --quiet file=/cdrom/install/preseed.cfg locale=en_US keymap=us hostname=sole domain=local.len
EOF

echo 'systemctl enable ssh' >> kali-config/common/hooks/01-start-ssh.chroot
chmod +x kali-config/common/hooks/01-start-ssh.chroot

wget https://www.kali.org/dojo/preseed.cfg -O ./kali-config/common/includes.installer/preseed.cfg

mkdir -p kali-config/common/includes.chroot/usr/share/images/desktop-base/
wget https://www.kali.org/dojo/blackhat-2015/wp-blue.png -O kali-config/common/includes.chroot/usr/share/images/desktop-base/kali-wallpaper_1920x1080.png

# end build
./build.sh --distribution kali-rolling --variant xfce --arch amd64 --verbose

