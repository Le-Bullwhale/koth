#!/bin/bash

file_path=$(find / -name "king.txt" 2>/dev/null)
keyword="Bsokimi"

# Check if the file exists
if [ -f "$file_path" ]; then
  # Read the first line of the file
  first_line=$(head -n 1 "$file_path")

  # Check if the first line contains the keyword
  if [[ "$first_line" == *"$keyword"* ]]; then
    message="Attention All! The king is now '$keyword'. All hail '$keyword'!"
    echo "$message" | wall
  fi
fi
