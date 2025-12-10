# Kubernetes 集群管理

## Purpose

管理 Kubernetes 集群的完整生命周期，包括安装、升级、扩容和卸载。提供从系统初始化到集群组件部署的全流程自动化能力。

**状态**: ✅ 已实现
**代码位置**: `roles/kubernetes/`

---

## Requirements

### Requirement: 系统初始化 (Bootstrap)

系统 SHALL 在部署 Kubernetes 之前完成节点初始化，包括时间同步、内核参数优化、软件源配置和必要软件包安装。

**代码位置**: `roles/kubernetes/components/bootstrap/`

#### Scenario: 节点初始化成功
- **GIVEN** 一台全新的 CentOS/RHEL 服务器
- **WHEN** 执行 bootstrap 角色
- **THEN** 系统完成 chrony 时间同步、sysctl 内核参数优化、limits.conf 资源限制配置和 YUM 软件源配置

#### Scenario: 节点需要重启
- **GIVEN** 内核参数变更需要重启生效
- **WHEN** bootstrap 任务完成
- **THEN** 系统自动重启并等待恢复

---

### Requirement: 证书管理 (Certificate)

系统 SHALL 使用 CFSSL 为 Kubernetes 各组件生成 TLS 证书，确保集群通信安全。

**代码位置**: `roles/kubernetes/components/certificate/`

#### Scenario: 生成集群证书
- **GIVEN** CFSSL 工具已安装
- **WHEN** 执行 certificate 角色
- **THEN** 生成 CA 根证书、API Server 证书、etcd 集群证书和各组件客户端证书

---

### Requirement: etcd 集群部署

系统 SHALL 部署高可用的 etcd 集群作为 Kubernetes 的数据存储后端。

**代码位置**: `roles/kubernetes/components/etcd/`

#### Scenario: 部署 3 节点 etcd 集群
- **GIVEN** 3 台服务器已完成初始化和证书配置
- **WHEN** 执行 etcd 角色
- **THEN** etcd 集群正常运行，各节点状态健康

#### Scenario: etcd 证书配置
- **GIVEN** CA 证书已生成
- **WHEN** 部署 etcd
- **THEN** etcd 使用 TLS 加密进行节点间通信

---

### Requirement: Docker 容器运行时

系统 SHALL 在所有节点安装和配置 Docker 作为容器运行时。

**代码位置**: `roles/container/docker/`

#### Scenario: 安装 Docker
- **GIVEN** YUM 软件源已配置
- **WHEN** 执行 docker 角色
- **THEN** Docker 服务安装并启动

---

### Requirement: Kubernetes Master 部署

系统 SHALL 在 Master 节点部署 Kubernetes 控制平面组件。

**代码位置**: `roles/kubernetes/components/master/`

#### Scenario: 部署单 Master 节点
- **GIVEN** 一台服务器已完成前置准备
- **WHEN** 执行 master 角色
- **THEN** 部署 kube-apiserver、kube-controller-manager 和 kube-scheduler

#### Scenario: 部署高可用 Master
- **GIVEN** 3 台服务器配置为 Master
- **WHEN** 执行 master 角色
- **THEN** 所有 Master 节点运行控制平面组件

---

### Requirement: Kubernetes Worker 部署

系统 SHALL 在 Worker 节点部署 Kubernetes 工作负载组件。

**代码位置**: `roles/kubernetes/components/worker/`

#### Scenario: 部署 Worker 节点
- **GIVEN** Master 节点已部署完成
- **WHEN** 执行 worker 角色
- **THEN** Worker 节点加入集群并处于 Ready 状态

---

### Requirement: kubeconfig 配置

系统 SHALL 生成各组件所需的 kubeconfig 配置文件。

**代码位置**: `roles/kubernetes/components/kubeconfig/`

#### Scenario: 生成 kubeconfig
- **GIVEN** 证书已生成
- **WHEN** 执行 kubeconfig 角色
- **THEN** 生成 admin.kubeconfig、kubelet.kubeconfig 和 kube-proxy.kubeconfig

---

### Requirement: Calico 网络插件

系统 SHALL 部署 Calico 作为 Kubernetes 的 CNI 网络插件。

**代码位置**: `roles/kubernetes/components/calico/`

#### Scenario: 部署 Calico
- **GIVEN** Kubernetes 集群已部署
- **WHEN** 执行 calico 角色
- **THEN** Pod 网络正常工作，节点间可互通

---

### Requirement: CoreDNS 服务发现

系统 SHALL 部署 CoreDNS 作为集群内部 DNS 服务。

**代码位置**: `roles/kubernetes/components/coredns/`

#### Scenario: 部署 CoreDNS
- **GIVEN** Kubernetes 集群和网络已就绪
- **WHEN** 执行 coredns 角色
- **THEN** 集群内 DNS 解析正常工作

---

### Requirement: Ingress Controller

系统 SHALL 部署 Ingress Controller 提供外部访问能力。

**代码位置**: `roles/kubernetes/components/ingress/`

#### Scenario: 部署 Ingress
- **GIVEN** Kubernetes 集群已就绪
- **WHEN** 执行 ingress 角色
- **THEN** Ingress Controller 正常运行

---

### Requirement: 集群安装命令

系统 SHALL 提供一键安装 Kubernetes 集群的能力。

**代码位置**: `roles/kubernetes/cluster/install/`

#### Scenario: 全新安装集群
- **GIVEN** 目标服务器已准备就绪
- **WHEN** 执行安装命令
- **THEN** 完成完整的集群部署流程

---

### Requirement: 集群卸载命令

系统 SHALL 提供卸载 Kubernetes 集群的能力。

**代码位置**: `roles/kubernetes/cluster/remove/`

#### Scenario: 卸载集群
- **GIVEN** 已部署的 Kubernetes 集群
- **WHEN** 执行卸载命令
- **THEN** 清理所有 Kubernetes 组件和数据

---

### Requirement: 集群扩容命令

系统 SHALL 提供向已有集群添加节点的能力。

**代码位置**: `roles/kubernetes/cluster/scale/`

#### Scenario: 扩容 Worker 节点
- **GIVEN** 运行中的 Kubernetes 集群
- **WHEN** 执行扩容命令添加新节点
- **THEN** 新节点成功加入集群

---

### Requirement: 集群升级命令

系统 SHALL 提供升级 Kubernetes 集群版本的能力。

**代码位置**: `roles/kubernetes/cluster/upgrade/`

#### Scenario: 滚动升级集群
- **GIVEN** 运行中的低版本集群
- **WHEN** 执行升级命令
- **THEN** 集群滚动升级到新版本，业务无中断

---

## Design Notes

### 任务执行流程
每个角色遵循统一的任务结构：
1. `check.yml` - 前置条件检查
2. `config.yml` - 配置文件生成
3. `install.yml` / `generate.yml` - 安装或生成资源
4. `run.yml` - 启动服务
5. `state.yml` - 状态记录

### 状态管理
使用文件标记 (`register_run_status`) 记录任务执行状态，支持幂等执行。

### 模板系统
使用 Jinja2 模板 (`templates/json/`) 动态生成 Kubernetes 资源清单。
