#!/usr/bin/env bash
#
# add disk
#

echo "n
p
1


w
" | fdisk /dev/sdb && mkfs.xfs /dev/sdb1
partprobe
mkdir -p /data
mount /dev/sdb1 /data/
echo "/dev/sdb1               /data                   xfs     defaults        0 0" >> /etc/fstab
