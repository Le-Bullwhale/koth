#!/bin/bash

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
