# 应用部署

## Purpose

管理常用应用和中间件的自动化部署，包括容器化工具、监控组件和日志收集。提供各类应用和服务的标准化部署能力。

**状态**: ✅ 已实现
**代码位置**: `roles/container/`, `roles/observability/`

---

## Requirements

### Requirement: Docker 安装

系统 SHALL 在目标服务器安装和配置 Docker 容器运行时。

**代码位置**: `roles/container/docker/`

#### Scenario: 安装 Docker
- **GIVEN** 一台 CentOS/RHEL 服务器
- **WHEN** 执行 docker 角色
- **THEN** Docker 服务安装并启动，可正常运行容器

#### Scenario: 配置 Docker
- **GIVEN** Docker 已安装
- **WHEN** 应用配置
- **THEN** Docker daemon 配置完成包括镜像加速和存储驱动

---

### Requirement: Docker Compose 服务

系统 SHALL 安装 Docker Compose 并支持以 systemd 服务方式管理 Compose 项目。

**代码位置**: `roles/container/docker-compose/`

#### Scenario: 安装 Docker Compose
- **GIVEN** Docker 已安装
- **WHEN** 执行 docker-compose 角色
- **THEN** Docker Compose 可用

#### Scenario: 配置为 systemd 服务
- **GIVEN** Docker Compose 项目已定义
- **WHEN** 部署服务
- **THEN** Compose 项目以 systemd 服务方式运行，支持开机自启

---

### Requirement: Node Exporter 监控

系统 SHALL 部署 Prometheus Node Exporter 用于采集主机级别指标。

**代码位置**: `roles/observability/monitoring/node-exporter/`

#### Scenario: 部署 Node Exporter
- **GIVEN** 需要监控的服务器
- **WHEN** 执行 node-exporter 角色
- **THEN** Node Exporter 服务运行在默认端口 9100

#### Scenario: 配置 systemd 服务
- **GIVEN** Node Exporter 已安装
- **WHEN** 配置完成
- **THEN** 服务以 systemd 方式管理，支持自动重启

---

### Requirement: PostgreSQL Exporter 监控

系统 SHALL 部署 Prometheus PostgreSQL Exporter 用于采集 PostgreSQL 数据库指标。

**代码位置**: `roles/observability/monitoring/postgres-exporter/`

#### Scenario: 部署 PostgreSQL Exporter
- **GIVEN** PostgreSQL 数据库已运行
- **WHEN** 执行 postgres-exporter 角色
- **THEN** Exporter 连接数据库并暴露指标

#### Scenario: 配置数据库连接
- **GIVEN** 数据库连接信息
- **WHEN** 配置 Exporter
- **THEN** 正确连接目标数据库

---

### Requirement: Redis Exporter 监控

系统 SHALL 部署 Prometheus Redis Exporter 用于采集 Redis 指标。

**代码位置**: `roles/observability/monitoring/redis-exporter/`

#### Scenario: 部署 Redis Exporter
- **GIVEN** Redis 服务已运行
- **WHEN** 执行 redis-exporter 角色
- **THEN** Exporter 连接 Redis 并暴露指标

---

### Requirement: td-agent 日志收集

系统 SHALL 部署 td-agent (Fluentd) 用于收集和转发日志。

**代码位置**: `roles/observability/logging/td-agent/`

#### Scenario: 部署 td-agent
- **GIVEN** 需要收集日志的服务器
- **WHEN** 执行 td-agent 角色
- **THEN** td-agent 服务运行并按配置收集日志

#### Scenario: 配置日志转发
- **GIVEN** 日志收集目标配置
- **WHEN** 应用配置模板
- **THEN** 日志正确转发到目标系统

---

## Design Notes

### 角色结构
所有应用角色遵循统一结构：
- `defaults/main.yml` - 默认变量
- `tasks/main.yml` - 主任务入口
- `tasks/install.yml` - 安装任务
- `tasks/config.yml` - 配置任务
- `handlers/main.yml` - 服务重启处理器
- `templates/` - 配置模板

### systemd 集成
所有服务通过 systemd 管理，提供：
- 服务自动启动
- 失败自动重启
- 标准化日志输出

### 变量覆盖
通过 `defaults/` 和 `vars/` 分层管理配置，支持环境差异化。
