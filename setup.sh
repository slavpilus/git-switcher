#!/bin/bash

# Create directory structure
mkdir -p ssh-keys/work
mkdir -p ssh-keys/personal

echo "=== Git Account Docker Setup ==="
echo "This script will set up Docker containers for switching between Git accounts."

# Create Docker image
echo "Building Docker image..."
docker build -t git-account-switcher .

# Copy environment template if doesn't exist
echo "Creating environment file template..."
cp -n .env.example .env.example

# Create aliases
echo "Creating bash aliases..."
if [ -f "git-aliases.sh" ]; then
  echo "git-aliases.sh already exists, not overwriting."
else
  cp -n git-aliases.sh.example git-aliases.sh
fi

echo
echo "Setup complete! Follow these next steps:"
echo
echo "1. Copy your SSH keys to the appropriate directories:"
echo "   - Work keys to: $HOME/ssh-keys/work/"
echo "   - Personal keys to: $HOME/ssh-keys/personal/"
echo
echo "2. Configure your Git account information:"
echo "   - Copy the template: cp .env.example .env"
echo "   - Edit with your details: nano .env"
echo
echo "3. Add the aliases to your shell by adding this line to your ~/.bashrc or ~/.zshrc:"
echo "   source $(pwd)/git-aliases.sh"
echo
echo "4. To use, run 'git-work' or 'git-personal' from any directory you want to work in"
