all: pull push

.PHONY: pull push check dev pro vms

hosts = mysql_cluster
tags  = mysql-cluster

pull:
	git pull

push:
	git pull
	git add .
	git commit -m "Update."
	git push origin master

vms:
	ansible-playbook -i inventory/hosts-dev vms.yml --limit vsphere_vms --tags vsphere --diff

check:
	ansible-playbook -i inventory/hosts-pro site.yml  --limit $(hosts) --tags $(tags) --diff --check

ops:
	ansible-playbook -i inventory/hosts-ops test.yml --diff

dev:
	ansible-playbook -i inventory/hosts-dev site.yml --limit $(hosts) --tags $(tags) --diff

pro:
	ansible-playbook -i inventory/hosts-pro site.yml  --limit $(hosts) --tags $(tags) --diff





