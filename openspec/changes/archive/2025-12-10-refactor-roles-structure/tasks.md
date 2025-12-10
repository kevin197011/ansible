# Tasks: 重构 Roles 目录结构

## 1. 创建新目录结构
- [x] 1.1 创建 `_templates/` 目录
- [x] 1.2 创建 `common/` 目录结构
- [x] 1.3 创建 `container/` 目录结构
- [x] 1.4 创建 `kubernetes/` 目录结构
- [x] 1.5 创建 `networking/` 目录结构
- [x] 1.6 创建 `observability/` 目录结构
- [x] 1.7 创建 `virtualization/` 目录结构

## 2. 迁移角色
- [x] 2.1 迁移 `tools/base-role` → `_templates/base-role`
- [x] 2.2 迁移 `tools/cfssl` → `common/security/cfssl`
- [x] 2.3 迁移 `system/base` → `common/bootstrap`
- [x] 2.4 迁移 `tools/other` → `common/system-config`
- [x] 2.5 迁移 `system/vsphere` → `virtualization/vsphere`
- [x] 2.6 迁移 `apps/docker*` → `container/`
- [x] 2.7 迁移监控 exporters → `observability/monitoring/`
- [x] 2.8 迁移 `apps/td-agent` → `observability/logging/td-agent`
- [x] 2.9 迁移 `config/bind` → `networking/dns/bind`
- [x] 2.10 迁移 `k8s/cmd/*` → `kubernetes/cluster/`
- [x] 2.11 迁移 `k8s/pkg/*` → `kubernetes/components/`

## 3. 清理
- [x] 3.1 删除空目录 `deploy/`, `install/`
- [x] 3.2 删除旧目录结构 (`apps/`, `config/`, `k8s/`, `system/`, `tools/`)
- [x] 3.3 删除重复的 `k8s/pkg/docker`

## 4. 更新引用
- [x] 4.1 更新 `playbook/vsphere.yml` role 引用
- [x] 4.2 更新 `playbook/test.yml` role 引用
- [x] 4.3 更新 `roles/container/docker-compose/meta/main.yml` 依赖
- [x] 4.4 更新 `roles/kubernetes/components/etcd/meta/main.yml` 依赖

## 5. 文档更新
- [x] 5.1 创建 `roles/README.md` 说明新结构
- [x] 5.2 更新 `openspec/specs/k8s-cluster/spec.md` 代码路径
- [x] 5.3 更新 `openspec/specs/apps-deploy/spec.md` 代码路径
- [x] 5.4 更新 `openspec/specs/system-config/spec.md` 代码路径
- [x] 5.5 更新 `openspec/specs/infra-tools/spec.md` 代码路径
