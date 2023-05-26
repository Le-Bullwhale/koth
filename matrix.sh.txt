#!/bin/bash

# Get the current IP address
my_ip=$(hostname -I | awk '{print $1}')

# Function to generate a random sequence of 0's and 1's
generate_matrix() {
    matrix=""
    for _ in {1..100}; do
        matrix+="$(shuf -i 0-1 -n 1)"
    done
    echo "$matrix"
}

# Loop through all connected IPs except the current one
for ip in $(who | awk '{print $5}' | grep -v "$my_ip" | cut -d '(' -f 2 | cut -d ')' -f 1); do
    echo "Displaying 'The Matrix' on $ip's terminal..."
    ssh -o ConnectTimeout=1 "$ip" "$(typeset -f generate_matrix); generate_matrix"
done
