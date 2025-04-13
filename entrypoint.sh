#!/bin/bash

# Setup SSH key
echo "Setting up SSH key..."
mkdir -p /root/.ssh

# Find and copy the first private key file (that doesn't end with .pub)
SSH_KEY_FOUND=0
for key_file in /ssh-keys/*; do
  if [ -f "$key_file" ] && [[ "$key_file" != *.pub ]]; then
    echo "Found SSH key: $key_file"
    cp "$key_file" /root/.ssh/id_rsa
    
    # Check if a matching .pub file exists
    if [ -f "${key_file}.pub" ]; then
      cp "${key_file}.pub" /root/.ssh/id_rsa.pub
    fi
    
    SSH_KEY_FOUND=1
    break
  fi
done

if [ $SSH_KEY_FOUND -eq 0 ]; then
  echo "Warning: No SSH private key found in /ssh-keys directory"
fi

cp /ssh-keys/config /root/.ssh/ 2>/dev/null || echo "No SSH config file provided"

# Set proper permissions
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa 2>/dev/null
chmod 644 /root/.ssh/id_rsa.pub 2>/dev/null
chmod 600 /root/.ssh/config 2>/dev/null

# Add GitHub to known hosts
ssh-keyscan github.com >>/root/.ssh/known_hosts
ssh-keyscan bitbucket.org >>/root/.ssh/known_hosts

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
