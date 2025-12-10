# ============================================
# Ansible Infrastructure Makefile
# ============================================

.PHONY: help lint check dev ops pro test vms install-deps

# 默认变量
ENV   ?= dev
HOSTS ?= all
TAGS  ?= all

# 帮助信息
help:
	@echo "Ansible Infrastructure Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make <target> [ENV=dev|ops|pro] [HOSTS=group] [TAGS=tag]"
	@echo ""
	@echo "Targets:"
	@echo "  help         显示此帮助信息"
	@echo "  install-deps 安装 Ansible Collections 依赖"
	@echo "  lint         运行 ansible-lint 代码检查"
	@echo "  check        Dry-run 检查 (不执行变更)"
	@echo "  dev          部署到开发环境"
	@echo "  ops          部署到运维/测试环境"
	@echo "  pro          部署到生产环境"
	@echo "  test         运行测试 Playbook"
	@echo "  vms          创建 vSphere 虚拟机"
	@echo ""
	@echo "Examples:"
	@echo "  make dev HOSTS=k8s_cluster TAGS=bootstrap"
	@echo "  make pro HOSTS=k8s_masters TAGS=k8s-master"
	@echo "  make check ENV=pro HOSTS=all TAGS=docker"

# ============================================
# 依赖安装
# ============================================

install-deps:
	@echo "Installing Ansible Collections..."
	ansible-galaxy install -r requirements.yml
	@echo "Done."

# ============================================
# 代码检查
# ============================================

lint:
	@echo "Running ansible-lint..."
	ansible-lint
	@echo "Running yamllint..."
	yamllint . -c .yamllint.yml || true

fmt: lint

# ============================================
# Playbook 执行
# ============================================

# Dry-run 检查
check:
	ansible-playbook -i inventory/hosts-$(ENV) site.yml \
		--limit $(HOSTS) \
		--tags $(TAGS) \
		--check \
		--diff

# 开发环境部署
dev:
	ansible-playbook -i inventory/hosts-dev site.yml \
		--limit $(HOSTS) \
		--tags $(TAGS) \
		--diff

# 运维/测试环境部署
ops:
	ansible-playbook -i inventory/hosts-ops site.yml \
		--limit $(HOSTS) \
		--tags $(TAGS) \
		--diff

# 生产环境部署
pro:
	ansible-playbook -i inventory/hosts-pro site.yml \
		--limit $(HOSTS) \
		--tags $(TAGS) \
		--diff

# 测试 Playbook
test:
	ansible-playbook -i inventory/hosts-ops test.yml --diff

# vSphere 虚拟机管理
vms:
	ansible-playbook -i inventory/hosts-dev vms.yml \
		--limit vsphere_vms \
		--tags vsphere \
		--diff

# ============================================
# Vagrant 本地测试
# ============================================

vagrant-up:
	vagrant up

vagrant-reload:
	vagrant reload --provision

vagrant-ssh:
	vagrant ssh

vagrant-destroy:
	vagrant destroy -f

# ============================================
# 实用工具
# ============================================

# 检查主机连通性
ping:
	ansible -i inventory/hosts-$(ENV) $(HOSTS) -m ping

# 列出主机
list-hosts:
	ansible -i inventory/hosts-$(ENV) $(HOSTS) --list-hosts

# 显示变量
show-vars:
	ansible -i inventory/hosts-$(ENV) $(HOSTS) -m debug -a "var=hostvars[inventory_hostname]"
