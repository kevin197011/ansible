#!/usr/bin/env bash


hosts=(
    172.16.1.2
    172.16.1.3
    172.16.1.4
    172.16.1.5
)

user_name='ansible'
user_passwd='xxxxxx'

# yum install -y sshpass
for host_ip in "${hosts[@]}"; do
    echo "Config ${host_ip} ssh key."
    sshpass -p ${user_passwd} ssh-copy-id -o StrictHostKeyChecking=no -f ${user_name}@${host_ip} -p ${host_port:-22}
done
