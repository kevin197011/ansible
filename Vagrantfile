# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'ansible-master'
    vb.memory = '8192‬'
    v.cpus = '4'
  end

  config.vm.provision 'shell', inline: <<-SHELL
    echo "hello world!"
    yum install ansible -y
  SHELL
end
