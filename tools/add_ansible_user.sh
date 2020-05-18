#!/usr/bin/env bash
#
# add ansible user
#


password='xxxxxx'

useradd ansible
echo "ansible:${password}" | chpasswd
grep -q 'ansible     ALL=(ALL)   NOPASSWD: ALL' /etc/sudoers || echo 'ansible     ALL=(ALL)   NOPASSWD: ALL' >> /etc/sudoers
