#!/bin/sh
# script to generate initrd that sets up nfsroot on bridge


ARCH=$1
URL=http://http.debian.net/debian/pool/main/b/busybox/busybox-static_1.22.0-9+deb8u1_${ARCH}.deb
package=`basename $URL`
wget -nv -nc $URL
rm -rf initramfs.*.cpio initramfs.*.cpio.gz tmp
dpkg-deb -x $package tmp/
mkdir -p tmp/etc/udhcpc
cp default.script tmp/etc/udhcpc
rm -rf tmp/usr/
cp init tmp/
cd tmp; find . | cpio -H newc -o > ../initramfs.${ARCH}.cpio
cd ..; gzip -9 initramfs.${ARCH}.cpio

