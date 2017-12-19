USER=$$(id -un)
GROUP=$$(id -gn)

bash:
	install -o ${USER} -g ${GROUP} -m 0644 .bash_profile $(HOME)

sh:
	install -o ${USER} -g ${GROUP} -m 0644 .profile ${HOME}

zsh:
	install -o ${USER} -g ${GROUP} -m 0644 .zshrc ${HOME}

shells: bash sh zsh

vim:
	install -o ${USER} -g ${GROUP} -m 0644 .vimrc ${HOME}

ex:
	install -o ${USER} -g ${GROUP} -m 0644 .exrc ${HOME}

all: shells vim ex
