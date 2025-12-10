# 系统配置

## Purpose

管理服务器基础系统配置和虚拟化平台集成。提供服务器操作系统的初始化配置，以及与 VMware vSphere 虚拟化平台的集成能力。

**状态**: ✅ 已实现
**代码位置**: `roles/common/`, `roles/virtualization/`

---

## Requirements

### Requirement: 基础系统配置 (Bootstrap)

系统 SHALL 完成服务器的基础系统配置，包括时间同步、内核参数、资源限制和软件源。

**代码位置**: `roles/common/bootstrap/`

#### Scenario: 时间同步配置
- **GIVEN** 一台新服务器
- **WHEN** 执行 bootstrap 角色
- **THEN** chrony 服务配置并同步 NTP 时间

#### Scenario: 内核参数优化
- **GIVEN** 需要优化的系统参数
- **WHEN** 应用 sysctl 配置
- **THEN** 内核参数按模板配置生效

#### Scenario: 资源限制配置
- **GIVEN** 系统资源限制需求
- **WHEN** 应用 limits.conf 配置
- **THEN** 文件句柄和进程数等限制按配置生效

#### Scenario: YUM 软件源配置
- **GIVEN** 自定义软件源地址
- **WHEN** 执行 repo 配置
- **THEN** YUM 软件源指向正确的仓库地址

#### Scenario: 需要重启生效
- **GIVEN** 某些配置需要重启
- **WHEN** 配置完成
- **THEN** 系统自动重启并等待恢复

---

### Requirement: 系统配置管理

系统 SHALL 提供系统级别的配置管理能力，包括 SELinux、内核升级和软件更新。

**代码位置**: `roles/common/system-config/`

#### Scenario: SELinux 配置
- **GIVEN** 需要调整 SELinux 状态
- **WHEN** 执行 selinux 任务
- **THEN** SELinux 按配置设置为 disabled 或 permissive 或 enforcing

#### Scenario: 内核升级
- **GIVEN** 需要升级内核版本
- **WHEN** 执行 kernel 任务
- **THEN** 内核升级到指定版本

#### Scenario: 系统更新
- **GIVEN** 需要更新系统软件包
- **WHEN** 执行 update 任务
- **THEN** 系统软件包更新到最新版本

---

### Requirement: vSphere 虚拟机管理

系统 SHALL 提供与 VMware vSphere 平台的集成，支持虚拟机的创建和管理。

**代码位置**: `roles/virtualization/vsphere/`

#### Scenario: 创建虚拟机
- **GIVEN** vSphere 连接信息和虚拟机配置
- **WHEN** 执行 vsphere 创建任务
- **THEN** 在 vSphere 平台创建新虚拟机

#### Scenario: 批量创建虚拟机
- **GIVEN** 虚拟机配置列表
- **WHEN** 执行批量创建
- **THEN** 按配置创建所有虚拟机

---

## Design Notes

### 任务流程
bootstrap 角色执行流程：
1. `check.yml` - 检查当前状态
2. `install.yml` - 安装必要软件包
3. `config.yml` - 应用配置文件
4. `reboot.yml` - 按需重启系统
5. `state.yml` - 记录执行状态

### 配置模板
- `chrony.conf.j2` - NTP 时间同步配置
- `sysctl.conf.j2` - 内核参数配置
- `limits.conf.j2` - 资源限制配置
- `base.repo.j2` - YUM 软件源配置

### vSphere 集成
使用 Ansible vmware 模块与 vSphere API 交互，支持：
- 虚拟机生命周期管理
- 从模板克隆虚拟机
- 自定义虚拟机规格
