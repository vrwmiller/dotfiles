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
   /usr/bin/ssh-add -l
}

# sshenv_verify looks for, sources, and validates the ssh environment, if
# applicable. It is applicable when SSH_ENV is set and exists on the filesystem.
#
# Return 0 if the PID is running and non-zero otherwise.
sshenv_verify()
{
   if [ -f "${SSH_ENV}" ]; then
      echo "Verifying SSH_ENV..."
      . "${SSH_ENV}" > /dev/null
      ps ${SSH_AGENT_PID} > /dev/null
      return $?
   fi

   return 1
}

# Do these things when we have a tty
if env tty > /dev/null; then

   # Set user prompt
   export PS1="${USER}@\h \$ "

   # Conditionally load and/or initializa the ssh environment
   if ! sshenv_verify; then
      sshagent_start
   else
      echo "ssh-agent has the following identities:"
      /usr/bin/ssh-add -l
   fi

fi
