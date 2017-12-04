# Set vi-style key bindings
set -o vi

# Set variables
EDITOR=vi

# Set user prompt.  This is bash specific and may not work with other shells
case `id -u` in
        0) PS1="\u@\h \w # ";;
        *) PS1="\u@\h \w $ ";;
esac

export EDITOR PS1
