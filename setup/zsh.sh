#!/bin/bash

sudo dnf -y install zsh

if ! grep -q $(which zsh) /etc/shells; then
	sudo sh -c "echo $(which zsh) >> /etc/shells"
fi
sudo chsh -s $(which zsh)
chsh -s $(which zsh)
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
