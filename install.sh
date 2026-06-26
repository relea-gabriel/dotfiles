#!/bin/bash

# 1. Ensure local bin and config directories exist
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"

# 2. Install Starship (Unattended, scoped to user directory)
echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"

# 3. Install Kubeswitch (switcher)
echo "Installing Kubeswitch..."
curl -L -o switcher https://github.com/danielfoehrKn/kubeswitch/releases/latest/download/switcher_linux_amd64
chmod +x switcher
mv switcher "$HOME/.local/bin/switcher"

# Install the original awsp package
echo "Installing awsp..."
npm install -g awsp --prefix "$HOME/.local"

# Install fzf (Fuzzy Finder)
echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --bin
cp "$HOME/.fzf/bin/fzf" "$HOME/.local/bin/"

# 4. Force overwrite default workspace files with our custom dotfiles
DOTFILES_DIR="$HOME/.config/coderv2/dotfiles"
echo "Applying custom configurations..."
cp -f "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
cp -f "$DOTFILES_DIR/.profile" "$HOME/.profile"
cp -f "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

echo "Workspace setup complete!"