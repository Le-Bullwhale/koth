#!/bin/bash

# SSH Configuration file path
ssh_config_file="/etc/ssh/sshd_config"

# Login banner script path
login_banner_script="/etc/ssh/login-banner"

# Message to be displayed
message="You are too late, start a new game - Bsokimi is the king of this game."

# Check if the script is run with root/superuser privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with root/superuser privileges."
    exit 1
fi

# Check if the SSH configuration file exists
if [[ ! -f $ssh_config_file ]]; then
    echo "SSH configuration file not found: $ssh_config_file"
    exit 1
fi

# Modify SSH configuration to enable the login banner
sed -i '/^#Banner/s/^#//' "$ssh_config_file"

# Create the login banner script
echo "#!/bin/bash" > "$login_banner_script"
echo "echo \"$message\" | wall" >> "$login_banner_script"

# Set permissions for the login banner script
chmod +x "$login_banner_script"

# Restart SSH service
systemctl restart ssh

echo "SSH login banner has been set successfully."
