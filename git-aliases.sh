# Support both bash and zsh environments
if [ -n "${ZSH_VERSION}" ]; then
  # For zsh
  SCRIPT_PATH=${(%):-%x}
  SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
elif [ -n "${BASH_VERSION}" ]; then
  # For bash
  SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
fi
ENV_FILE="${SCRIPT_DIR}/.env"

if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
else
  echo "Error: $ENV_FILE not found. Exiting..."
  return 1 2>/dev/null || exit 1
fi

alias git-work='docker run -it --rm \
  -e GIT_USER_NAME="$WORK_GIT_NAME" \
  -e GIT_USER_EMAIL="$WORK_GIT_EMAIL" \
  -v $(pwd):/git-workspace \
  -v ${SCRIPT_DIR}/ssh-keys/work:/ssh-keys \
  git-account-switcher'

alias git-personal='docker run -it --rm \
  -e GIT_USER_NAME="$PERSONAL_GIT_NAME" \
  -e GIT_USER_EMAIL="$PERSONAL_GIT_EMAIL" \
  -v $(pwd):/git-workspace \
  -v ${SCRIPT_DIR}/ssh-keys/personal:/ssh-keys \
  git-account-switcher'
