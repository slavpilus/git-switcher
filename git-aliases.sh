# GitHub Account Switcher Aliases
alias github-work='docker run -it --rm \
  -e GIT_USER_NAME="Your Work Name" \
  -e GIT_USER_EMAIL="your.work.email@company.com" \
  -v $(pwd):/git-workspace \
  -v $HOME/ssh-keys/work:/ssh-keys \
  github-account-switcher'

alias github-personal='docker run -it --rm \
  -e GIT_USER_NAME="Your Personal Name" \
  -e GIT_USER_EMAIL="your.personal.email@gmail.com" \
  -v $(pwd):/git-workspace \
  -v $HOME/ssh-keys/personal:/ssh-keys \
  github-account-switcher'
