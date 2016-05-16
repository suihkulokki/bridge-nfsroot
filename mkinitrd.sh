#!/bin/sh
# script to generate initrd that sets up nfsroot on bridge

rm -rf initramfs.cpio initramfs.cpio.gz tmp
[ -r busybox-static_1.22.0-19_arm64.deb ] || wget http://ftp.fi.debian.org/debian/pool/main/b/busybox/busybox-static_1.22.0-19_arm64.deb
dpkg-deb -x busybox-static*deb tmp/
mkdir -p tmp/etc/udhcpc
cp default.script tmp/etc/udhcpc
rm -rf tmp/usr/
cp init tmp/
cd tmp; find . | cpio -H newc -o > ../initramfs.cpio
cd ..; gzip initramfs.cpio 

