#!/bin/bash

# Create directory structure
mkdir -p ssh-keys/work
mkdir -p ssh-keys/personal

echo "=== Git Account Docker Setup ==="
echo "This script will set up Docker containers for switching between Git accounts."

# Create Docker image
echo "Building Docker image..."
docker build -t git-account-switcher .

# Create aliases
echo "Creating bash aliases..."

cat >git-aliases.sh <<'EOF'
# Git Account Switcher Aliases
alias git-work='docker run -it --rm \
  -e GIT_USER_NAME="Your Work Name" \
  -e GIT_USER_EMAIL="your.work.email@company.com" \
  -v $(pwd):/git-workspace \
  -v $HOME/ssh-keys/work:/ssh-keys \
  git-account-switcher'

alias git-personal='docker run -it --rm \
  -e GIT_USER_NAME="Your Personal Name" \
  -e GIT_USER_EMAIL="your.personal.email@gmail.com" \
  -v $(pwd):/git-workspace \
  -v $HOME/ssh-keys/personal:/ssh-keys \
  git-account-switcher'
EOF

echo
echo "Setup complete! Follow these next steps:"
echo
echo "1. Copy your SSH keys to the appropriate directories:"
echo "   - Work keys to: $HOME/ssh-keys/work/"
echo "   - Personal keys to: $HOME/ssh-keys/personal/"
echo
echo "2. Add the aliases to your shell by adding this line to your ~/.bashrc or ~/.zshrc:"
echo "   source $(pwd)/git-aliases.sh"
echo
echo "3. Update the aliases in git-aliases.sh with your actual Git user names and emails"
echo
echo "4. To use, run 'git-work' or 'git-personal' from any directory you want to work in"
