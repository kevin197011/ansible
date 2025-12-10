# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network 'private_network', ip: '192.168.33.10'
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.hostname = 'ansible-test'

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--name', 'DevOps']
    vb.customize ['modifyvm', :id, '--memory', '1024']
    vb.customize ['modifyvm', :id, '--cpus', '1']
  end

  # config.vm.provision 'shell', inline: <<-SHELL
  #   echo "hello world!"
  #   yum install epel-release -y
  #   yum install vim -y
  #   yum install ansible -y
  # SHELL

  config.vm.provision 'ansible' do |ansible|
    #  ansible.verbose = "v"
    ansible.playbook = 'test.yml'
    # ansible.vault_password_file = "vault_password_file"
  end
end
