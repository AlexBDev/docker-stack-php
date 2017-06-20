#!/bin/bash

confirm()
{
    read -r -p "${1} [y/N] " response

    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if ! confirm "The /etc/hosts file will be modified do you want to continue ?"; then
        exit 0
fi

# Static ip of PHP container
IP_CONTAINER="172.40.0.10"

if grep "#[[:space:]]\{0,\}$IP_CONTAINER" /etc/hosts > /dev/null; then
	echo "$IP_CONTAINER is commented in your /etc/hosts"
elif ! grep "$IP_CONTAINER" /etc/hosts > /dev/null; then
	echo "Add entry $IP_CONTAINER in /etc/hosts"
	echo -e "\n#Docker stack php\n$IP_CONTAINER\n" >> /etc/hosts
fi

# Add domain name to /etc/hosts in sites dir
for DOMAIN_NAME in $(sed -n 's/server_name\(.*\);/\1/p' sites/*)
do
	printf "Domain name "
	if ! grep "$IP_CONTAINER.*[[:space:]]\{1,\}$DOMAIN_NAME" /etc/hosts > /dev/null; then
		printf "[ ADD ] : "
		sed -i "/$IP_CONTAINER/s/$/ $DOMAIN_NAME/" /etc/hosts > /dev/null # Add new domain name to /etc/hosts
	else
		printf "[ FOUND ]: "
	fi
	printf "$DOMAIN_NAME\n"
done
