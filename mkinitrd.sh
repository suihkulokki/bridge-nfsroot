#!/bin/bash
# script to generate initrd that sets up nfsroot on bridge


ARCH=$1
URL="http://http.debian.net/debian/pool/main/b/busybox/busybox-static_1.22.0-9+deb8u1_${ARCH}.deb"
package=$(basename "$URL")
wget -nv -nc "$URL"
rm -rf "initramfs.${ARCH}.cpio" "initramfs.${ARCH}.cpio.gz"
dpkg-deb -x "$package" tmp/
mkdir -p tmp/etc/udhcpc
cp default.script tmp/etc/udhcpc
cp init tmp/
(
    cd tmp
    find . | cpio -H newc -o > "../initramfs.${ARCH}.cpio"
)
gzip -9 "initramfs.${ARCH}.cpio"
rm -rf tmp/

