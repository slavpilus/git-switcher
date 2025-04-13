#!/bin/bash

# Setup SSH key
echo "Setting up SSH key..."
mkdir -p /root/.ssh
cp /ssh-keys/id_rsa /root/.ssh/
cp /ssh-keys/id_rsa.pub /root/.ssh/
cp /ssh-keys/config /root/.ssh/ 2>/dev/null || echo "No SSH config file provided"

# Set proper permissions
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/config 2>/dev/null

# Add GitHub to known hosts
ssh-keyscan github.com >>/root/.ssh/known_hosts
ssh-keyscan bitbucket.org >>root/.ssh/known_hosts

# Configure Git user
if [ ! -z "$GIT_USER_NAME" ] && [ ! -z "$GIT_USER_EMAIL" ]; then
  echo "Configuring Git user: $GIT_USER_NAME <$GIT_USER_EMAIL>"
  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"
fi

# If a command is provided, execute it. Otherwise, start a bash session.
if [ $# -eq 0 ]; then
  exec bash
else
  exec "$@"
fi
