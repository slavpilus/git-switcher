# Git Account Switcher

This solution helps manage multiple Git accounts (work and personal) on the same machine using Docker containers. Each container maintains its own SSH configuration, making it easy to switch between Git accounts without manually changing SSH keys. Works on both macOS and Linux.

## How It Works

1. We create Docker containers that:
   - Mount your local filesystem to access your Git repositories
   - Use specific SSH keys based on which account you want to use
   - Configure Git with the appropriate user name and email

2. You can switch between Git accounts by simply using different aliases.

## Setup Instructions

### Prerequisites

- Docker installed on your system (macOS or Linux)
- SSH keys already generated for each Git account

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/slavpilus/git-switcher.git
   cd git-switcher
   ```

2. Make the scripts executable:
   ```bash
   chmod +x entrypoint.sh setup.sh
   ```

3. Run the setup script:
   ```bash
   ./setup.sh
   ```

4. Copy your SSH keys to the directories created by the setup script (adjust to match your SSH keys names):
   - Work SSH keys:
     ```bash
     cp ~/.ssh/id_rsa_work ~/ssh-keys/work/id_rsa
     cp ~/.ssh/id_rsa_work.pub ~/ssh-keys/work/id_rsa.pub
     ```
   - Personal SSH keys:
     ```bash
     cp ~/.ssh/id_rsa_personal ~/ssh-keys/personal/id_rsa
     cp ~/.ssh/id_rsa_personal.pub ~/ssh-keys/personal/id_rsa.pub
     ```

5. Configure your Git account information:
   ```bash
   # Copy the template
   cp .env.example .env
   
   # Edit with your actual details
   nano .env
   ```

6. Add the aliases to your shell configuration:
   ```bash
   echo "source $(pwd)/git-aliases.sh" >> ~/.zshrc  # or ~/.bashrc if you use bash
   ```

7. Reload your shell configuration:
   ```bash
   source ~/.zshrc  # or ~/.bashrc
   ```

## Usage

### Switch to Work Git Account

Navigate to any Git repository directory and run:
```bash
git-work
```

This will open a shell inside a Docker container with your work Git credentials. Once executed, you'll be inside the Docker container environment (your prompt will change). You can run git commands as usual:
```bash
git clone git@git-server:work-org/project.git
git push origin main
```

To exit the Docker container and return to your host system, simply type:
```bash
exit
```
or press `Ctrl+D`.

### Switch to Personal Git Account

Similarly, to use your personal Git account:
```bash
git-personal
```

This also launches a Docker container with your personal Git credentials. Exit using the same method described above.

### Additional Features

- **One-off Git Commands**: You can also run one-off commands like:
  ```bash
  git-work git clone git@git-server:work-org/project.git
  ```
  In this case, the container will automatically exit after executing the command.

## Troubleshooting

1. **SSH Key Permissions**: If you encounter permission issues, make sure your SSH keys have the correct permissions:
   ```bash
   chmod 600 ~/ssh-keys/work/id_rsa
   chmod 644 ~/ssh-keys/work/id_rsa.pub
   chmod 600 ~/ssh-keys/personal/id_rsa
   chmod 644 ~/ssh-keys/personal/id_rsa.pub
   ```

2. **SSH Connection Issues**: To test the SSH connection within the container:
   ```bash
   git-work ssh -T git@git-server
   ```
   You should see a message like: "Hi username! You've successfully authenticated..."

## Advanced Configuration

If you have more complex SSH setups or want to use specific SSH configurations, you can create an `ssh_config` file in each of the SSH key directories with custom configurations.
