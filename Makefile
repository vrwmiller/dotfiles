USER=demo
GROUP=demo
HOME=/home
HOMEDIR=${HOME}/${USER}

bash:
	install -o ${USER} -g ${GROUP} -m 0644 .bash_profile ${HOMEDIR}/.bash_profile

sh:
	install -o ${USER} -g ${GROUP} -m 0644 .profile ${HOMEDIR}/.profile

zsh:
	install -o ${USER} -g ${GROUP} -m 0644 .zshrc ${HOMEDIR}/.zshrc

shells: bash sh zsh

vim:
	install -o ${USER} -g ${GROUP} -m 0644 .vimrc ${HOMEDIR}/.vimrc

all: shells vim
