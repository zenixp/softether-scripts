# SoftEther VPN 脚本

一组用于便捷使用 SoftEther VPN Client 的脚本。

## 概述

此仓库包含用于自动化安装、配置和管理 SoftEther VPN Client 的 shell 脚本。这些脚本通过处理依赖安装、客户端构建和连接管理来简化设置 VPN 连接的过程。

## 脚本

### 1. client_install.sh

自动安装依赖项并从提供的软件包构建 SoftEther VPN Client。

**使用方法:**
```bash
./client_install.sh <softether-vpnclient-package.tar.gz>
```

**功能:**
- 自动检测操作系统 (CentOS/RHEL/Fedora/Debian/Ubuntu)
- 根据检测到的操作系统安装所需依赖
- 解压并构建 SoftEther VPN Client

### 2. create.sh

使用指定参数创建和配置新的 VPN 连接。

**使用方法:**
```bash
./create.sh --server <server> --username <username> --password <password> [--nic <nic_name>] [--account <account_name>] [--hub <hub_name>] [--password-type <password_type>] [--basedir <basedir>]
```

**参数:**
- `--server`: VPN 服务器地址 (必需)
- `--username`: VPN 用户名 (必需)
- `--password`: VPN 密码 (必需)
- `--nic`: 网络接口名称 (默认: vpn)
- `--account`: 账户名称 (默认: default)
- `--hub`: 集线器名称 (默认: DEFAULT)
- `--password-type`: 密码类型 (默认: standard)
- `--basedir`: vpnclient 的基础目录 (默认: ./vpnclient)

### 3. start.sh

启动 VPN 连接并为 VPN 接口分配 IP 地址。

**使用方法:**
```bash
./start.sh --ip <ip_address/24> [--nic <nic_name>] [--account <account_name>] [--basedir <basedir>]
```

**参数:**
- `--ip`: 分配给 VPN 接口的 IP 地址 (必需)
- `--nic`: 网络接口名称 (默认: vpn)
- `--account`: 账户名称 (默认: default)
- `--basedir`: vpnclient 的基础目录 (默认: ./vpnclient)

## 系统要求

- Linux 操作系统 (CentOS/RHEL/Fedora/Debian/Ubuntu)
- Root 或 sudo 权限用于安装依赖
- SoftEther VPN Client 软件包 (可从 https://www.softether.org/ 获取)

## 安装步骤

1. 从官方网站下载 SoftEther VPN Client 软件包
2. 以软件包文件为参数运行 client_install.sh 脚本
3. 使用 create.sh 配置 VPN 连接
4. 使用 start.sh 建立 VPN 连接

## 使用示例

```bash
# 安装并构建 SoftEther VPN Client
./client_install.sh softether-vpnclient-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz

# 创建 VPN 连接
./create.sh --server vpn.example.com:10443 --username myuser --password mypassword --account myaccount

# 启动 VPN 连接并分配 IP 地址
./start.sh --ip 192.168.30.10/24 --account myaccount
```

## 许可证

本项目采用 MIT 许可证。