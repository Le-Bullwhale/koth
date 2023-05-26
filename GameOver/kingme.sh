#!/bin/bash

file_path=$(find / -name "king.txt" 2>/dev/null)

# Check if the file exists
if [[ ! -f "$file_path" ]]; then
  echo "Error: king.txt not found."
  exit 1
fi

# Remove the chattr attribute from the file
sudo chattr -i "$file_path"

echo "Chattr attribute removed from $file_path."
