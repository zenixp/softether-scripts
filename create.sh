#!/bin/sh

# Default value settings
VPN_NIC=vpn
VPN_ACCOUNT=default
VPN_HUB=DEFAULT
VPN_PASSWORD_TYPE=standard
BASEDIR=$(pwd)/vpnclient

# Parse key-value parameters
while [[ $# -gt 0 ]]; do
    case $1 in
        --server)
            VPN_SERVER="$2"
            shift 2
            ;;
        --username)
            VPN_USERNAME="$2"
            shift 2
            ;;
        --password)
            VPN_PASSWORD="$2"
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
        --hub)
            VPN_HUB="$2"
            shift 2
            ;;
        --password-type)
            VPN_PASSWORD_TYPE="$2"
            shift 2
            ;;
        --basedir)
            BASEDIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter: $1"
            echo "Usage: $0 --server <server> --username <username> --password <password> [--nic <nic_name>] [--account <account_name>] [--hub <hub_name>] [--password-type <password_type>]  [--basedir <basedir>]"
            exit 1
            ;;
    esac
done

# Required variable check
if [ -z "$VPN_SERVER" ] || [ -z "$VPN_USERNAME" ] || [ -z "$VPN_PASSWORD" ]; then
    echo "Error: --server, --username, --password are required parameters"
    echo "Usage: $0 --server <server> --username <username> --password <password> [--nic <nic_name>] [--account <account_name>] [--hub <hub_name>] [--password-type <password_type>]  [--basedir <basedir>]"
    exit 1
fi

$BASEDIR/vpnclient start
sleep 5

cat << EOF > $BASEDIR/setup.txt
NicCreate $VPN_NIC
NicList
AccountCreate $VPN_ACCOUNT /SERVER:$VPN_SERVER /HUB:$VPN_HUB /USERNAME:$VPN_USERNAME /NICNAME:$VPN_NIC
AccountPasswordSet $VPN_ACCOUNT /PASSWORD:$VPN_PASSWORD /TYPE:$VPN_PASSWORD_TYPE
AccountConnect $VPN_ACCOUNT
AccountList
EOF

$BASEDIR/vpncmd /client localhost /in:$BASEDIR/setup.txt
rm $BASEDIR/setup.txt