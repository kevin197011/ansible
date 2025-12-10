# Ansible Infrastructure Automation

基于 Ansible 的基础设施自动化项目，用于管理 Kubernetes 集群及相关基础设施的部署和配置。

## 📋 功能特性

- **Kubernetes 集群管理**: 支持集群的安装、升级、扩容和卸载
- **容器运行时**: Docker 和 Docker Compose 部署管理
- **可观测性**: Prometheus Exporters 监控、td-agent 日志收集
- **系统配置**: 基础系统优化、时间同步、内核参数调优
- **虚拟化集成**: VMware vSphere 虚拟机管理
- **安全管理**: CFSSL 证书生成、Ansible Vault 加密

## 🏗️ 项目结构

```
ansible/
├── ansible.cfg              # Ansible 配置文件
├── requirements.yml         # Collections/Roles 依赖
├── Makefile                 # 常用命令快捷方式
│
├── inventory/               # 主机清单
│   ├── hosts-dev            # 开发环境
│   ├── hosts-ops            # 运维/测试环境
│   ├── hosts-pro            # 生产环境
│   └── group_vars/          # 组变量
│       ├── all.yml          # 全局变量
│       └── k8s_cluster.yml  # K8s 集群变量
│
├── roles/                   # Ansible 角色 (DevOps 风格)
│   ├── _templates/          # 🔧 内部角色模板
│   ├── common/              # 🏗️ 通用基础
│   │   ├── bootstrap/       # 系统初始化
│   │   ├── security/        # 安全工具 (cfssl)
│   │   └── system-config/   # 系统配置
│   ├── container/           # 🐳 容器运行时
│   │   ├── docker/
│   │   └── docker-compose/
│   ├── kubernetes/          # ☸️ Kubernetes
│   │   ├── cluster/         # 集群操作 (install/remove/scale/upgrade)
│   │   └── components/      # 组件 (etcd/master/worker/calico/coredns...)
│   ├── networking/          # 🌐 网络服务
│   │   └── dns/bind/        # BIND DNS
│   ├── observability/       # 📊 可观测性
│   │   ├── monitoring/      # 监控 (node/postgres/redis-exporter)
│   │   └── logging/         # 日志 (td-agent)
│   └── virtualization/      # 💻 虚拟化
│       └── vsphere/         # VMware vSphere
│
├── playbook/                # Playbook 文件
├── plugins/                 # 自定义插件
├── tools/                   # 辅助脚本
├── secrets/                 # 加密的敏感信息
└── openspec/                # 项目规格文档
```

## 🚀 快速开始

### 前置条件

- Ansible 2.14+
- Python 3.9+
- SSH 密钥访问目标主机

### 安装依赖

```bash
# 安装 Ansible Collections
make install-deps
# 或
ansible-galaxy install -r requirements.yml

# 验证安装
ansible --version
```

### 配置 Inventory

1. 复制示例配置：
```bash
cp inventory/hosts-dev inventory/hosts-myenv
```

2. 编辑主机清单，配置目标服务器 IP：
```ini
[k8s_masters]
master-01 ansible_host=192.168.1.10

[k8s_workers]
worker-01 ansible_host=192.168.1.11
worker-02 ansible_host=192.168.1.12
```

### 运行 Playbook

```bash
# 检查连通性
make ping ENV=dev HOSTS=all

# Dry-run 模式检查
make check ENV=dev HOSTS=k8s_cluster TAGS=bootstrap

# 执行部署
make dev HOSTS=k8s_cluster TAGS=bootstrap
```

## 📖 使用指南

### Kubernetes 集群部署

```bash
# 系统初始化
make dev HOSTS=k8s_cluster TAGS=bootstrap

# 部署 etcd 集群
make dev HOSTS=etcd TAGS=etcd

# 部署 Master 节点
make dev HOSTS=k8s_masters TAGS=k8s-master

# 部署 Worker 节点
make dev HOSTS=k8s_workers TAGS=k8s-worker

# 部署网络插件
make dev HOSTS=k8s_masters TAGS=calico
```

### 容器运行时

```bash
# 部署 Docker
make dev HOSTS=all TAGS=docker

# 部署 Docker Compose 服务
make dev HOSTS=all TAGS=docker-compose
```

### 监控和日志

```bash
# 部署 Node Exporter
make dev HOSTS=all TAGS=node-exporter

# 部署日志收集
make dev HOSTS=all TAGS=td-agent
```

### 系统初始化

```bash
# 基础系统配置 (时间同步、内核参数等)
make dev HOSTS=all TAGS=bootstrap

# 系统配置 (SELinux、软件更新等)
make dev HOSTS=all TAGS=system-config
```

## 🔧 Makefile 命令

```bash
make help  # 显示所有可用命令
```

| 命令 | 说明 |
|------|------|
| `make help` | 显示帮助信息 |
| `make install-deps` | 安装 Ansible Collections 依赖 |
| `make lint` | 运行 ansible-lint 代码检查 |
| `make ping ENV=dev HOSTS=all` | 测试主机连通性 |
| `make check ENV=dev HOSTS=xxx TAGS=xxx` | Dry-run 检查 |
| `make dev HOSTS=xxx TAGS=xxx` | 部署到开发环境 |
| `make ops HOSTS=xxx TAGS=xxx` | 部署到运维环境 |
| `make pro HOSTS=xxx TAGS=xxx` | 部署到生产环境 |
| `make test` | 运行测试 Playbook |
| `make list-hosts ENV=dev HOSTS=all` | 列出主机 |

## 🔐 安全

### Ansible Vault

敏感信息使用 Ansible Vault 加密：

```bash
# 查看加密文件
ansible-vault view secrets/secrets.yml

# 编辑加密文件
ansible-vault edit secrets/secrets.yml

# 加密新文件
ansible-vault encrypt myfile.yml

# 运行时提供密码
ansible-playbook site.yml --ask-vault-pass
```

**Vault 密码文件**: `config/values.sec` (已在 .gitignore 中排除)

### 敏感信息管理

- 密码、API 密钥等敏感信息存放在 `secrets/` 目录
- 所有敏感文件使用 Ansible Vault 加密
- 不要将未加密的敏感信息提交到版本控制

## 🧪 测试

### 本地测试 (Vagrant)

```bash
# 启动测试虚拟机
vagrant up

# 运行测试
make test

# SSH 进入虚拟机
make vagrant-ssh

# 销毁虚拟机
make vagrant-destroy
```

### 代码检查

```bash
# 运行 ansible-lint
make lint

# 语法检查
ansible-playbook --syntax-check site.yml
```

## 📚 文档

详细的项目规格和能力文档：

- [Roles 说明](roles/README.md) - 角色目录结构和使用说明
- [OpenSpec 规格](openspec/specs/) - 功能规格文档
- [项目上下文](openspec/project.md) - 项目约定和技术栈

### 主要能力模块

| 模块 | 说明 | 文档 |
|------|------|------|
| k8s-cluster | Kubernetes 集群管理 | [spec](openspec/specs/k8s-cluster/spec.md) |
| apps-deploy | 应用和服务部署 | [spec](openspec/specs/apps-deploy/spec.md) |
| system-config | 系统配置管理 | [spec](openspec/specs/system-config/spec.md) |
| infra-tools | 基础设施工具 | [spec](openspec/specs/infra-tools/spec.md) |

## 🤝 贡献

请参考 [CONTRIBUTING.md](CONTRIBUTING.md) 了解贡献指南。

提交代码前请确保:

1. 运行 `make lint` 通过代码检查
2. 遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范
3. 更新相关文档和 OpenSpec 规格

### 提交示例

```bash
# 功能
git commit -m "feat(kubernetes): add cluster upgrade support"

# 修复
git commit -m "fix(docker): correct registry mirror config"

# 文档
git commit -m "docs: update README with new roles structure"
```

## 📄 许可证

[MIT License](LICENSE)

---

**维护者**: [Your Name]
**最后更新**: 2025-12-10
