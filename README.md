# Ansible Infrastructure Automation

基于 Ansible 的基础设施自动化项目，用于管理 Kubernetes 集群及相关基础设施的部署和配置。

## 📋 功能特性

- **Kubernetes 集群管理**: 支持集群的安装、升级、扩容和卸载
- **应用部署**: Docker、监控组件 (Prometheus Exporters)、日志收集 (td-agent)
- **系统配置**: 基础系统优化、时间同步、内核参数调优
- **虚拟化集成**: VMware vSphere 虚拟机管理
- **安全管理**: 证书生成 (CFSSL)、Ansible Vault 加密

## 🏗️ 项目结构

```
ansible/
├── ansible.cfg              # Ansible 配置文件
├── requirements.yml         # Collections/Roles 依赖
├── inventory/               # 主机清单
│   ├── hosts-dev           # 开发环境
│   ├── hosts-ops           # 运维/测试环境
│   ├── hosts-pro           # 生产环境
│   └── group_vars/         # 组变量
├── roles/                   # Ansible 角色
│   ├── k8s/                # Kubernetes 相关
│   │   ├── cmd/            # 集群操作命令
│   │   └── pkg/            # 集群组件
│   ├── apps/               # 应用部署
│   ├── system/             # 系统配置
│   ├── tools/              # 工具角色
│   └── config/             # 服务配置
├── playbook/               # Playbook 文件
├── plugins/                # 自定义插件
├── tools/                  # 辅助脚本
└── openspec/               # 项目规格文档
```

## 🚀 快速开始

### 前置条件

- Ansible 2.14+
- Python 3.9+
- SSH 密钥访问目标主机

### 安装依赖

```bash
# 安装 Ansible Collections
ansible-galaxy install -r requirements.yml

# 验证安装
ansible --version
```

### 配置 Inventory

1. 复制示例配置：
```bash
cp inventory/hosts-dev inventory/hosts-myenv
```

2. 编辑主机清单，配置目标服务器 IP

### 运行 Playbook

```bash
# 检查连通性
ansible -i inventory/hosts-dev all -m ping

# Dry-run 模式检查
ansible-playbook -i inventory/hosts-dev site.yml --check --diff

# 执行部署
ansible-playbook -i inventory/hosts-dev site.yml
```

## 📖 使用指南

### Kubernetes 集群部署

```bash
# 部署完整集群
make dev HOSTS=k8s_cluster TAGS=k8s-install

# 仅部署 Master 节点
make dev HOSTS=k8s_masters TAGS=k8s-master

# 扩容 Worker 节点
make dev HOSTS=k8s_workers TAGS=k8s-scale
```

### 应用部署

```bash
# 部署 Docker
make dev HOSTS=all TAGS=docker

# 部署监控组件
make dev HOSTS=all TAGS=node-exporter
```

### 系统初始化

```bash
# 基础系统配置
make dev HOSTS=all TAGS=system-base
```

## 🔧 Makefile 命令

| 命令 | 说明 |
|------|------|
| `make lint` | 运行 ansible-lint 代码检查 |
| `make check ENV=dev` | Dry-run 检查 (不执行变更) |
| `make dev HOSTS=xxx TAGS=xxx` | 部署到开发环境 |
| `make pro HOSTS=xxx TAGS=xxx` | 部署到生产环境 |
| `make test` | 运行测试 Playbook |

## 🔐 安全

### Ansible Vault

敏感信息使用 Ansible Vault 加密：

```bash
# 查看加密文件
ansible-vault view secrets/xxx.yml

# 编辑加密文件
ansible-vault edit secrets/xxx.yml

# 运行时提供密码
ansible-playbook site.yml --ask-vault-pass
```

Vault 密码文件位置: `config/values.sec` (已在 .gitignore 中排除)

## 🧪 测试

```bash
# 使用 Vagrant 进行本地测试
vagrant up
make test

# 运行 ansible-lint
make lint
```

## 📚 文档

详细的项目规格和能力文档请参考:

- [OpenSpec 规格文档](openspec/specs/)
- [项目上下文](openspec/project.md)

## 🤝 贡献

请参考 [CONTRIBUTING.md](CONTRIBUTING.md) 了解贡献指南。

提交代码前请确保:

1. 运行 `make lint` 通过代码检查
2. 遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范
3. 更新相关文档

## 📄 许可证

[MIT License](LICENSE)
