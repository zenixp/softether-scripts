#!/bin/sh
# Auto-install dependencies and build SoftEther VPN Client

# 1. Check for input argument
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
case "$OS" in
    centos|rhel|rocky|almalinux|fedora)
        echo "Installing dependencies using yum..."
        yum -y install gcc zlib-devel openssl-devel readline-devel ncurses-devel
        ;;
    debian|ubuntu)
        echo "Installing dependencies using apt-get..."
        apt-get update -y
        apt-get install -y build-essential
        ;;
    *)
        echo "⚠️ Unsupported OS detected. Please install dependencies manually."
        exit 1
        ;;
esac

# 6. Build SoftEther VPN Client
if [ -d "vpnclient" ]; then
    cd vpnclient || exit 1
else
    echo "❌ 'vpnclient' directory not found after extraction."
    exit 1
fi

make

echo "✅ SoftEther VPN Client build completed successfully."
