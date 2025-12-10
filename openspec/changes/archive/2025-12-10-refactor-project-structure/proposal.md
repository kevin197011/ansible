# Change: 重构项目结构以符合 Ansible 最佳实践

## Why

当前项目架构基础良好，但存在以下问题需要改进：
- `group_vars/` 变量文件几乎为空，缺少通用配置
- 缺少 `requirements.yml` 依赖管理文件
- Inventory 主机分组不够细粒度（缺少 master/worker 分组）
- README.md 文档不完整
- 缺少 CI/CD 自动化配置
- Makefile 中的提交命令不符合 Conventional Commits 规范

## What Changes

- 完善 `group_vars/all.yml` 添加通用变量配置
- 添加 `requirements.yml` 管理 Ansible Collections 和外部角色依赖
- 优化 inventory 文件，添加细粒度主机分组（masters/workers/etcd）
- 完善 README.md 项目文档
- 添加 GitHub Actions CI/CD 配置（ansible-lint）
- 改进 Makefile，移除不规范的提交命令

## Impact

- Affected specs: system-config, k8s-cluster
- Affected code:
  - `inventory/hosts-*`
  - `inventory/group_vars/`
  - `requirements.yml` (新文件)
  - `README.md`
  - `.github/workflows/` (新目录)
  - `Makefile`

