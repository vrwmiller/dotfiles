# History-related behavior
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory
setopt sharehistory
setopt INC_APPEND_HISTORY
bindkey -v

# Shell prompt
PROMPT="%n@%m %1~ $ "

# source local environment
[ -f .zshrc.local ] && source .zshrc.local

# source aliases
[ -f aliases.sh ] && source aliases.sh

# SSH agent management
SSH_ENV="${HOME}/.ssh/environment"

sshagent_start() {
  echo -n "Initialize ssh-agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo "done"
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add -l
}

sshenv_validate() {
  if [ -f "${SSH_ENV}" ]; then
    echo "Verifying SSH_ENV..."
    . "${SSH_ENV}" > /dev/null
    ps ${SSH_AGENT_PID} > /dev/null
    return $?
  fi
  return 1
}

if ! sshenv_validate; then
  sshagent_start
else
  echo "ssh-agent has the following identities:"
  /usr/bin/ssh-add -l
fi
