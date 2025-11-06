#!/bin/sh

# Default value settings
IP_ADDRESS=
VPN_NIC=vpn
VPN_ACCOUNT=default
BASEDIR=$(pwd)/vpnclient

# Parse key-value parameters
while [[ $# -gt 0 ]]; do
    case $1 in
        --ip)
            IP_ADDRESS="$2"
            shift 2
            ;;
        --nic)
            VPN_NIC="$2"
            shift 2
            ;;
        --account)
            VPN_ACCOUNT="$2"
            shift 2
            ;;
        --basedir)
            BASEDIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter: $1"
            echo "Usage: $0 --ip <ip_address/24> [--nic <nic_name>] [--account <account_name>] [--basedir <basedir>]"
            exit 1
            ;;
    esac
done

# Required variable check
if [ -z "$IP_ADDRESS" ]; then
    echo "Error: --ip is a required parameter"
    echo "Usage: $0 --ip <ip_address/24> [--nic <nic_name>] [--account <account_name>] [--basedir <basedir>]"
    exit 1
fi

$BASEDIR/vpnclient start
$BASEDIR/vpncmd /client localhost /cmd AccountConnect $VPN_ACCOUNT
ip addr add $IP_ADDRESS dev vpn_$VPN_NIC