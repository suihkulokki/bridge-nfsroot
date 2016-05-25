= building initrd for bridged ethernet =

This script builds a initrd for mounting nfs-root on a bridge device. For example to use with arm64/qemu, get a kernel with bridge module compiled in. Pass the architecture you want to build the initrd for as first parameter.

= usage =

./mkinitrd arm64

= example boot =

qemu-system-aarch64 -m 1024 -cpu cortex-a57 -M virt -kernel Image -initrd initramfs.cpio.gz -netdev bridge,id=e0 -device virtio-net-device,netdev=e0 -nographic -append "earlycon root=/dev/nfs rootdelay=5 console=ttyAMA0 ip=dhcp nfsroot=10.42.0.52:/nfs/jessie-arm64"



