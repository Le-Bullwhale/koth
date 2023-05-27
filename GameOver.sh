#!/bin/bash

# Ask the user for the folder to deploy
read -p "Which folder do you want to deploy? " folder_name

# Construct the full path of the folder
folder_path=$(realpath "./$folder_name")

# Check if the folder exists
if [[ ! -d "$folder_path" ]]; then
  echo "Error: $folder_path folder not found."
  exit 1
fi

# Grant executable permissions to all files in the folder and its subdirectories
find "$folder_path" -type f -exec chmod +rx {} \;

echo "Executable permissions granted to all files in the $folder_path folder and its subdirectories."

# Get a list of script files in the directory
scripts=$(ls "$folder_path"/script*)

# Check if there are any script files
if [[ -z "$scripts" ]]; then
  echo "Error: No script files found in $folder_path."
  exit 1
fi

# Iterate over each script and execute it
for script in $scripts; do
  echo "Running $script..."
  bash "$script"
done

echo "All scripts executed successfully."

