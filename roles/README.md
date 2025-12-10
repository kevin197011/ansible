# Ansible Roles

本目录采用 DevOps 风格组织，按功能域清晰分类。

## 📁 目录结构

```
roles/
├── _templates/              # 🔧 内部模板 (以下划线开头)
│   └── base-role/           # 标准角色模板
│
├── common/                  # 🏗️ 通用基础
│   ├── bootstrap/           # 系统初始化 (时间同步、内核参数、资源限制)
│   ├── security/            # 安全相关
│   │   └── cfssl/           # 证书生成工具
│   └── system-config/       # 系统配置 (SELinux、内核升级、软件更新)
│
├── container/               # 🐳 容器运行时
│   ├── docker/              # Docker 安装配置
│   └── docker-compose/      # Docker Compose 服务
│
├── kubernetes/              # ☸️ Kubernetes 集群
│   ├── cluster/             # 集群操作
│   │   ├── install/         # 安装集群
│   │   ├── remove/          # 卸载集群
│   │   ├── scale/           # 扩容集群
│   │   └── upgrade/         # 升级集群
│   └── components/          # 集群组件
│       ├── bootstrap/       # K8s 节点初始化
│       ├── certificate/     # 集群证书
│       ├── etcd/            # etcd 集群
│       ├── master/          # 控制平面
│       ├── worker/          # 工作节点
│       ├── kubeconfig/      # kubeconfig 配置
│       ├── calico/          # CNI 网络插件
│       ├── coredns/         # 集群 DNS
│       └── ingress/         # Ingress Controller
│
├── networking/              # 🌐 网络服务
│   └── dns/
│       └── bind/            # BIND DNS 服务器
│
├── observability/           # 📊 可观测性
│   ├── monitoring/          # 监控
│   │   ├── node-exporter/   # 主机指标
│   │   ├── postgres-exporter/ # PostgreSQL 指标
│   │   └── redis-exporter/  # Redis 指标
│   └── logging/             # 日志
│       └── td-agent/        # Fluentd 日志收集
│
└── virtualization/          # 💻 虚拟化平台
    └── vsphere/             # VMware vSphere
```

## 🎯 设计原则

### 1. 按功能域分类
- **common**: 所有服务器都需要的基础配置
- **container**: 容器相关的运行时环境
- **kubernetes**: K8s 集群专属
- **networking**: 网络服务
- **observability**: 监控和日志
- **virtualization**: 虚拟化平台集成

### 2. 命名规范
- 目录名使用小写和连字符 (kebab-case)
- 内部模板目录以下划线 `_` 开头
- 角色名应简洁且具有描述性

### 3. 角色结构
每个角色遵循 Ansible 标准结构:
```
role-name/
├── defaults/main.yml    # 默认变量
├── vars/main.yml        # 角色变量
├── tasks/main.yml       # 主任务入口
├── handlers/main.yml    # 处理器
├── templates/           # Jinja2 模板
├── files/               # 静态文件
├── meta/main.yml        # 元数据和依赖
└── tests/               # 测试
```

## 📖 使用示例

### 引用角色
```yaml
# playbook.yml
- hosts: all
  roles:
    - common/bootstrap
    - container/docker

- hosts: k8s_masters
  roles:
    - kubernetes/components/master
```

### 按标签执行
```bash
# 仅执行 bootstrap
ansible-playbook site.yml --tags bootstrap

# 部署 Kubernetes 组件
ansible-playbook site.yml --tags k8s-master,k8s-worker
```

## 🔗 相关文档

- [项目 README](../README.md)
- [OpenSpec 规格文档](../openspec/specs/)

