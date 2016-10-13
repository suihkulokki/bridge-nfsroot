Initrd for booting NFS root with bridge interface
=================================================

To use networking efficiently in KVM/QEMU, you need to use bridged network mode. If you have a diskless system and are booting with NFS root, switching network from plain eth0 to bridge interface is not possible, because you lose access to rootfs during the transition. So the most reliable way is to enable the bridge in initrd, and and then mount the rootfs.

This script does that in the most minimal way - a static busybox binary and the shell commands needed to enable bridge and mount NFS root.

Usage
-----------

Pass the target architecture as first parameter:

./mkinitrd arm64

Qemu example
-----------

Example for booting QEMU for aarch64 using a bridged NFSROOT:

`
qemu-system-aarch64 -m 1024 -cpu cortex-a57 -M virt -kernel Image -initrd initramfs.arm64.cpio.gz -netdev bridge,id=e0 -device virtio-net-device,netdev=e0 -nographic -append "earlycon root=/dev/nfs rootdelay=5 console=ttyAMA0 ip=dhcp nfsroot=10.0.2.2:/nfs/jessie-arm64"
`


