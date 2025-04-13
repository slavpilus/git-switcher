ENV_FILE=".env"
if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
else
  echo "Error: $ENV_FILE not found. Exiting..."
  exit 1
fi

alias git-work='docker run -it --rm \
  -e GIT_USER_NAME="$WORK_GIT_NAME" \
  -e GIT_USER_EMAIL="$WORK_GIT_EMAIL" \
  -v $(pwd):/git-workspace \
  -v $HOME/ssh-keys/work:/ssh-keys \
  git-account-switcher'

alias git-personal='docker run -it --rm \
  -e GIT_USER_NAME="$PERSONAL_GIT_NAME" \
  -e GIT_USER_EMAIL="$PERSONAL_GIT_EMAIL" \
  -v $(pwd):/git-workspace \
  -v $HOME/ssh-keys/personal:/ssh-keys \
  git-account-switcher'
