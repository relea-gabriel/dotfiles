#!/bin/bash

# 1. Ensure local bin and config directories exist
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"

# 2. Install Starship (Unattended)
echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# 3. Install Kubeswitch (switcher)
echo "Installing Kubeswitch..."
curl -L -o switcher https://github.com/danielfoehrKn/kubeswitch/releases/latest/download/switcher_linux_amd64
chmod +x switcher
mv switcher "$HOME/.local/bin/switcher"

# 4. Copy the Starship config file to the proper directory
# (Assuming this script is running from inside your cloned dotfiles repo)
cp starship.toml "$HOME/.config/starship.toml"

echo "Workspace setup complete!"