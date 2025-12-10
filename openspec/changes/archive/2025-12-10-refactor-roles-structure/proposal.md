# Change: 重构 Roles 目录结构为 DevOps 风格

## Why

当前 roles 目录结构存在以下问题：
- `deploy/` 和 `install/` 为空目录，无实际内容
- `apps/` 混合了容器运行时、监控和日志等不同职责的角色
- `k8s/pkg/docker` 与 `apps/docker` 存在重复
- `tools/other` 命名不明确，难以理解其用途
- `config/` 命名过于通用，仅包含 DNS 配置
- 缺乏清晰的层次结构和职责划分

## What Changes

采用 DevOps 风格重构 roles 目录，按功能域清晰分类：

### 新结构
```
roles/
├── _templates/         # 角色模板 (内部使用，以下划线开头)
├── common/             # 通用基础
│   ├── bootstrap/      # 系统初始化
│   └── security/       # 安全配置 (证书等)
├── container/          # 容器运行时
│   └── docker/         # Docker 安装配置
├── kubernetes/         # Kubernetes 集群
│   ├── cluster/        # 集群操作 (install/remove/scale/upgrade)
│   └── components/     # 集群组件 (etcd/master/worker/calico/coredns/ingress)
├── networking/         # 网络服务
│   └── dns/            # DNS 服务 (BIND)
├── observability/      # 可观测性
│   ├── monitoring/     # 监控 (exporters)
│   └── logging/        # 日志 (td-agent)
└── virtualization/     # 虚拟化平台
    └── vsphere/        # VMware vSphere
```

### 映射关系
| 旧路径 | 新路径 |
|--------|--------|
| `tools/base-role` | `_templates/base-role` |
| `tools/cfssl` | `common/security/cfssl` |
| `tools/other` | `common/bootstrap` |
| `system/base` | `common/bootstrap` (合并) |
| `system/vsphere` | `virtualization/vsphere` |
| `apps/docker` | `container/docker` |
| `apps/docker-compose` | `container/docker-compose` |
| `apps/node-exporter` | `observability/monitoring/node-exporter` |
| `apps/postgres-exporter` | `observability/monitoring/postgres-exporter` |
| `apps/redis-exporter` | `observability/monitoring/redis-exporter` |
| `apps/td-agent` | `observability/logging/td-agent` |
| `config/bind` | `networking/dns/bind` |
| `k8s/cmd/*` | `kubernetes/cluster/*` |
| `k8s/pkg/*` | `kubernetes/components/*` |
| `deploy/` | 删除 (空目录) |
| `install/` | 删除 (空目录) |

## Impact

- **BREAKING**: 所有引用 roles 路径的 playbook 需要更新
- Affected specs: k8s-cluster, apps-deploy, system-config, infra-tools
- Affected code: `playbook/*.yml`, `site.yml`, `base.yml`

