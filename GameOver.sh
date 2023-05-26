#!/bin/bash

folder_path=$(find / -type d -name "koth" 2>/dev/null)

# Check if the folder exists
if [[ ! -d "$folder_path" ]]; then
  echo "Error: koth folder not found."
  exit 1
fi

# Grant executable permissions to all files in the folder and its subdirectories
find "$folder_path" -type f -exec chmod +rx {} \;

echo "Executable permissions granted to all files in the koth folder and its subdirectories."

script_dir="/gameover"

# Check if the directory exists
if [[ ! -d "$script_dir" ]]; then
  echo "Error: $script_dir directory not found."
  exit 1
fi

# Get a list of script files in the directory
scripts=$(ls "$script_dir"/script*)

# Check if there are any script files
if [[ -z "$scripts" ]]; then
  echo "Error: No script files found in $script_dir."
  exit 1
fi

# Iterate over each script and execute it
for script in $scripts; do
  echo "Running $script..."
  bash "$script"
done

echo "All scripts executed successfully."
