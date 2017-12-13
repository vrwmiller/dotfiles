# Set vi-style key bindings
set -o vi

# Set variables
PATH="${PATH}:/usr/local/bin:${HOME}/bin"
EDITOR=vi
CHILD=`whoami`
PARENT=`who am i | awk '{print $1}'`
HISTSIZE=100000
HISTFILE="${HOME}/.bash_history-for-${PARENT}-as-${CHILD}
SSH_ENV="${HOME}/.ssh/environment"

export PATH EDITOR CHILD PARENT HISTSIZE HISTFILE

# Functions

# Start ssh-agent
sshagent_start()
{
  echo -n "Initialize ssh-agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo "done"
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add -l
}

# sshenv_validate looks for, sources, and validates the ssh environment, if
# applicable. It is applicable when SSH_ENV is set and exists on the filesystem.
#
# Return 0 if the PID is running and non-zero otherwise.
sshenv_validate()
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

   # Set user prompt; This is bash specific and may not work with other shells
   case `id -u` in
      0) export PS1="\u@\h \w # ";;
      *) export PS1="\u@\h \w $ ";;
   esac

   # Conditionally load and/or initializa the ssh environment
   if ! sshenv_validate; then
      sshagent_start
   else
      echo "ssh-agent has the following identities:"
      /usr/bin/ssh-add -l
   fi

fi
