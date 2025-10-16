#!/bin/bash
# Auto-install dependencies and build SoftEther VPN Client

# 1. Extract the package
if [ -z "$1" ]; then
    echo "Usage: $0 <softether-vpnclient-package.tar.gz>"
    exit 1
fi

PACKAGE_FILE=$1

# 2. Verify the file exists
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "❌ Package file not found: $PACKAGE_FILE"
    exit 1
fi

# 3. Extract the package
echo "Extracting package: $PACKAGE_FILE"
tar xf "$PACKAGE_FILE"

# 4. Detect the operating system
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    OS=$(uname -s)
fi

echo "Detected OS: $OS"

# 5. Install dependencies
if [[ "$OS" =~ ^(centos|rhel|rocky|almalinux|fedora)$ ]]; then
    echo "Installing dependencies using yum..."
    yum -y install gcc zlib-devel openssl-devel readline-devel ncurses-devel
elif [[ "$OS" =~ ^(debian|ubuntu)$ ]]; then
    echo "Installing dependencies using apt-get..."
    apt-get update -y
    apt-get install -y build-essential
else
    echo "⚠️ Unsupported OS detected. Please install dependencies manually."
    exit 1
fi

# 6. Build SoftEther VPN Client
cd vpnclient || { echo "❌ vpnclient directory not found."; exit 1; }
make

echo "✅ SoftEther VPN Client build completed successfully."
