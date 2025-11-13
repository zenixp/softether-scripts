# SoftEther VPN Scripts

A set of scripts for convenient use of SoftEther VPN Client on Linux systems.

## Languages

- [English](README.md)
- [中文](README_CN.md)

## Overview

This repository contains shell scripts that automate the installation, configuration, and management of SoftEther VPN Client. The scripts help simplify the process of setting up VPN connections by handling dependency installation, client building, and connection management.

## Scripts

### 1. client_install.sh

Automatically installs dependencies and builds the SoftEther VPN Client from a provided package.

**Usage:**
```bash
./client_install.sh <softether-vpnclient-package.tar.gz>
```

**Features:**
- Automatically detects the operating system (CentOS/RHEL/Fedora/Debian/Ubuntu)
- Installs required dependencies based on detected OS
- Extracts and builds the SoftEther VPN Client

### 2. create.sh

Creates and configures a new VPN connection with specified parameters.

**Usage:**
```bash
./create.sh --server <server> --username <username> --password <password> [--nic <nic_name>] [--account <account_name>] [--hub <hub_name>] [--password-type <password_type>] [--basedir <basedir>]
```

**Parameters:**
- `--server`: VPN server address (required)
- `--username`: VPN username (required)
- `--password`: VPN password (required)
- `--nic`: Network interface name (default: vpn)
- `--account`: Account name (default: default)
- `--hub`: Hub name (default: DEFAULT)
- `--password-type`: Password type (default: standard)
- `--basedir`: Base directory for vpnclient (default: ./vpnclient)

### 3. start.sh

Starts a VPN connection and assigns an IP address to the VPN interface.

**Usage:**
```bash
./start.sh --ip <ip_address/24> [--nic <nic_name>] [--account <account_name>] [--basedir <basedir>]
```

**Parameters:**
- `--ip`: IP address to assign to the VPN interface (required)
- `--nic`: Network interface name (default: vpn)
- `--account`: Account name (default: default)
- `--basedir`: Base directory for vpnclient (default: ./vpnclient)

## Requirements

- Linux operating system (CentOS/RHEL/Fedora/Debian/Ubuntu)
- Root or sudo privileges for dependency installation
- SoftEther VPN Client package (available from https://www.softether.org/)

## Installation Steps

1. Download the SoftEther VPN Client package from the official website
2. Run the client_install.sh script with the package file as parameter
3. Use create.sh to configure your VPN connection
4. Use start.sh to establish the VPN connection

## Example Usage

```bash
# Install and build SoftEther VPN Client
./client_install.sh softether-vpnclient-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz

# Create a VPN connection
./create.sh --server vpn.example.com:10443 --username myuser --password mypassword --account myaccount

# Start the VPN connection with IP assignment
./start.sh --ip 192.168.30.10/24 --account myaccount
```

## License

This project is licensed under the MIT License.