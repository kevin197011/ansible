# 基础设施工具

## Purpose

提供基础设施管理所需的工具集，包括证书管理、DNS 配置和辅助脚本。涵盖证书管理、DNS 服务配置和运维辅助脚本等能力。

**状态**: ✅ 已实现
**代码位置**: `roles/common/security/`, `roles/networking/`, `roles/_templates/`, `tools/`

---

## Requirements

### Requirement: CFSSL 证书工具

系统 SHALL 提供 CFSSL 工具的安装和配置，用于生成和管理 TLS 证书。

**代码位置**: `roles/common/security/cfssl/`

#### Scenario: 安装 CFSSL
- **GIVEN** 需要证书管理的服务器
- **WHEN** 执行 cfssl 角色
- **THEN** CFSSL 和 CFSSL-JSON 工具可用

#### Scenario: 生成证书
- **GIVEN** 证书签名请求配置
- **WHEN** 使用 CFSSL 生成证书
- **THEN** 生成有效的 TLS 证书和私钥

---

### Requirement: 基础角色模板 (Base Role)

系统 SHALL 提供标准化的 Ansible 角色模板，用于创建新角色时保持一致性。

**代码位置**: `roles/_templates/base-role/`

#### Scenario: 作为角色模板使用
- **GIVEN** 需要创建新角色
- **WHEN** 复制 base-role 结构
- **THEN** 新角色具有标准化的目录结构和任务流程

---

### Requirement: BIND DNS 服务

系统 SHALL 提供 BIND DNS 服务器的部署和配置能力。

**代码位置**: `roles/networking/dns/bind/`

#### Scenario: 部署 DNS 服务器
- **GIVEN** DNS 服务器配置需求
- **WHEN** 执行 bind 角色
- **THEN** BIND DNS 服务正常运行

#### Scenario: 配置 DNS 区域
- **GIVEN** 域名和记录配置
- **WHEN** 应用 zone 配置模板
- **THEN** DNS 区域文件正确生成，解析正常

---

### Requirement: Ansible 用户管理脚本

系统 SHALL 提供创建 Ansible 管理用户的辅助脚本。

**代码位置**: `tools/add_ansible_user.sh`

#### Scenario: 创建 Ansible 用户
- **GIVEN** 目标服务器
- **WHEN** 执行脚本
- **THEN** 创建 ansible 用户并配置 sudo 权限

---

### Requirement: SSH 密钥配置脚本

系统 SHALL 提供 SSH 密钥分发的辅助脚本。

**代码位置**: `tools/config_key.sh`

#### Scenario: 分发 SSH 公钥
- **GIVEN** SSH 公钥和目标服务器列表
- **WHEN** 执行脚本
- **THEN** 公钥添加到目标服务器的 authorized_keys

---

### Requirement: Ansible 安装脚本

系统 SHALL 提供 Ansible 控制节点安装的辅助脚本。

**代码位置**: `tools/install_ansible.sh`

#### Scenario: 安装 Ansible
- **GIVEN** 一台 Linux 服务器
- **WHEN** 执行脚本
- **THEN** Ansible 安装完成并可用

---

### Requirement: 系统初始化脚本

系统 SHALL 提供快速初始化系统的辅助脚本。

**代码位置**: `tools/init.sh`

#### Scenario: 初始化系统
- **GIVEN** 新服务器
- **WHEN** 执行脚本
- **THEN** 完成基础系统初始化

---

### Requirement: 连通性测试脚本

系统 SHALL 提供批量测试主机连通性的辅助脚本。

**代码位置**: `tools/ping.sh`

#### Scenario: 测试主机连通性
- **GIVEN** 主机清单
- **WHEN** 执行脚本
- **THEN** 显示各主机的连通状态

---

### Requirement: 磁盘管理脚本

系统 SHALL 提供磁盘扩展和管理的辅助脚本。

**代码位置**: `tools/add_disk.sh`

#### Scenario: 添加磁盘
- **GIVEN** 新添加的磁盘设备
- **WHEN** 执行脚本
- **THEN** 磁盘格式化、挂载并配置 fstab

---

### Requirement: Ansible Vault 工具

系统 SHALL 提供 Ansible Vault 密钥管理的辅助工具。

**代码位置**: `tools/vault.go`

#### Scenario: 管理 Vault 密钥
- **GIVEN** 需要加密的敏感信息
- **WHEN** 使用 vault 工具
- **THEN** 信息安全加密存储

---

## Design Notes

### 工具分类
- **角色模板** (`roles/_templates/`): 内部使用的标准角色模板
- **安全工具** (`roles/common/security/`): 证书管理等安全相关角色
- **网络服务** (`roles/networking/`): DNS 等网络服务配置
- **Shell 脚本** (`tools/`): 一次性或交互式操作脚本

### 密钥管理
- 敏感信息使用 Ansible Vault 加密
- Vault 密码文件位于 `config/values.sec`
- 密钥文件不应提交到版本控制

### DNS 配置模板
- `named.conf.j2` - BIND 主配置
- `domain.com.zone.j2` - 区域文件模板
