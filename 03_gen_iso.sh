#!/bin/bash
rm -rf $HOME/live_sole/chroot/02_chroot.sh
# START
mkdir -p $HOME/live_sole/image/{live,isolinux}

# IMAGE BUILD
cd $HOME/live_sole 
mksquashfs chroot image/live/filesystem.squashfs -e boot
cp chroot/boot/vmlinuz-* image/live/vmlinuz1
cp chroot/boot/initrd.img-* image/live/initrd1

# ISOLINUX.CFG
cat > $HOME/live_sole/image/isolinux/isolinux.cfg << EOF
UI menu.c32
prompt 0
menu title Sole live
timeout 300

label Sole live 2018
menu label ^Sole live 2018
menu default
kernel /live/vmlinuz1
append initrd=/live/initrd1 boot=live

label hdt
menu label ^Hardware Detection Tool(HDT)
kernel hdt.c32
text help 
HDT displays low-level information about the systems hardware.
endtext

label memtest86+
menu label ^Memory Failure Detection(memtest86+)
kernel /live/memtest
EOF

# ISOLINUX
cd $HOME/live_sole/image/ && \
	cp /usr/lib/ISOLINUX/isolinux.bin isolinux/ && \
	cp /usr/lib/syslinux/modules/bios/menu.c32 isolinux/ && \
	cp /usr/lib/syslinux/modules/bios/hdt.c32 isolinux/ && \
	cp /usr/lib/syslinux/modules/bios/ldlinux.c32 isolinux/ && \
	cp /usr/lib/syslinux/modules/bios/libutil.c32 isolinux/ && \
	cp /usr/lib/syslinux/modules/bios/libmenu.c32 isolinux/ && \
	cp /usr/lib/syslinux/modules/bios/libcom32.c32 isolinux/ && \
	cp /usr/lib/syslinux/modules/bios/libgpl.c32 isolinux/ && \
	cp /usr/share/misc/pci.ids isolinux/ && \
	cp /boot/memtest86+.bin live/memtest

# ISO BUILD
genisoimage \
	-rational-rock \
	-volid "Sole live" \
	-cache-inodes \
	-joliet \
	-hfs \
	-full-iso9660-filenames \
	-b isolinux/isolinux.bin \
	-c isolinux/boot.cat \
	-no-emul-boot \
	-boot-load-size 4 \
	-boot-info-table \
	-output $HOME/live_sole/sole-live.iso \
	$HOME/live_sole/image

