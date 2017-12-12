# Set vi-style key bindings
set -o vi

# Set variables
EDITOR=vi
SSH_ENV="${HOME}/.ssh/environment"

export EDITOR

# Start ssh-agent
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

   # Set user prompt; This is bash specific and may not work with other shells
   case `id -u` in
      0) export PS1="\u@\h \w # ";;
      *) export PS1="\u@\h \w $ ";;
   esac

   # Conditionally load the ssh environment
   if [ -e "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps ${SSH_AGENT_PID}
   else
      sshagent_start
   fi

fi
