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

# source aliases
[ -f aliases.sh ] && source aliases.sh

# Display available ssh keys
echo "--> Available ssh keys:"
ssh-add -l
