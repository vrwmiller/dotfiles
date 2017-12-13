# Set vi-style key bindings
set -o vi

# Variables
PATH="${PATH}:/usr/local/bin:${HOME}/bin"
EDITOR=vi
SSH_ENV="${HOME}/.ssh/environment"

export PATH EDITOR

# Functions

# Start an ssh-agent
sshagent_start()
{
   echo -n "Initialize ssh-agent..."
   /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
   echo "done"
   chmod 600 "${SSH_ENV}"
   . "${SSH_ENV}" > /dev/null
   /usr/bin/ssh-add;
}

# Do these things when we have a tty
if env tty > /dev/null; then

   # Set user prompt
   export PS1="${USER}@\h \$ "

   # Conditionally load and/or initializa the ssh environment
   if [ -f "${SSH_ENV}" ]; then
      echo "Verifying SSH_ENV..."
      . "${SSH_ENV}" > /dev/null
      ps ${SSH_AGENT_PID} || sshagent_start
   else
      sshagent_start
   fi

fi
