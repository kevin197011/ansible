# Project Context

## Purpose
这是一个 Ansible 自动化运维项目，用于管理和部署 Kubernetes 集群及相关基础设施。项目提供了从系统初始化、Kubernetes 集群部署、应用安装到监控配置的全流程自动化能力。

## Tech Stack
- **配置管理**: Ansible 2.9+
- **容器编排**: Kubernetes
- **容器运行时**: Docker
- **网络插件**: Calico
- **证书管理**: CFSSL
- **服务发现**: CoreDNS, Consul (可选)
- **数据存储**: etcd, MySQL (可选), Redis (可选)
- **监控**: Prometheus Exporters (Node, PostgreSQL, Redis)
- **日志收集**: td-agent (Fluentd)
- **虚拟化**: VMware vSphere

## Project Conventions

### Code Style
- 使用 YAML 格式编写所有 Playbook 和 Role
- 任务名称使用描述性的英文短语
- 变量使用 snake_case 命名
- 敏感信息使用 Ansible Vault 加密存储

### Architecture Patterns
- **角色分层**: 按功能分为 k8s/, apps/, system/, tools/, config/ 等目录
- **状态检查**: 每个角色包含 check.yml 进行前置条件验证
- **幂等性**: 所有任务设计为可重复执行
- **模块化**: 将复杂任务拆分为独立的子任务文件

### Testing Strategy
- 每个角色包含 tests/ 目录用于测试
- 使用 inventory 和 test.yml 进行角色测试
- 部署前通过 --check 模式进行 dry-run 验证

### Git Workflow
- 遵循 Conventional Commits 规范
- 使用 feature 分支进行开发
- 通过 Pull Request 合并代码

## Domain Context

### 环境分层
- **dev**: 开发环境
- **ops**: 运维/测试环境
- **pro**: 生产环境

### Kubernetes 组件
- **Master 节点**: API Server, Controller Manager, Scheduler
- **Worker 节点**: Kubelet, Kube-proxy
- **网络**: Calico CNI
- **DNS**: CoreDNS
- **存储**: etcd 集群

### 部署流程
1. 系统初始化 (base/bootstrap)
2. 证书生成 (certificate)
3. etcd 集群部署
4. Kubernetes Master 部署
5. Kubernetes Worker 部署
6. 网络插件部署 (Calico)
7. CoreDNS 部署
8. Ingress Controller 部署

## Important Constraints
- 目标系统: CentOS/RHEL 7+
- 网络要求: 节点间需要互通
- 权限要求: 需要 root 或 sudo 权限
- 时间同步: 所有节点需要 NTP 同步

## External Dependencies
- 需要预先配置好的 YUM 仓库
- 需要可访问的容器镜像仓库
- VMware vSphere (用于虚拟机管理)
