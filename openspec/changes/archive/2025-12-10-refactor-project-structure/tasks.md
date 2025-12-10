# Tasks: 重构项目结构

## 1. 变量管理
- [x] 1.1 完善 `group_vars/all.yml` 通用变量
- [x] 1.2 添加 `group_vars/k8s_cluster.yml` K8s 集群变量

## 2. 依赖管理
- [x] 2.1 创建 `requirements.yml` 文件

## 3. Inventory 优化
- [x] 3.1 优化 `hosts-dev` 添加 masters/workers 分组
- [x] 3.2 优化 `hosts-pro` 添加 masters/workers 分组
- [x] 3.3 优化 `hosts-ops` 结构

## 4. 文档完善
- [x] 4.1 完善 README.md 项目文档

## 5. CI/CD 配置
- [x] 5.1 添加 `.github/workflows/lint.yml`
- [x] 5.2 添加 `.yamllint.yml` 配置

## 6. 工具改进
- [x] 6.1 改进 Makefile
