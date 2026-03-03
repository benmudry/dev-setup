#!/bin/zsh

sudo dnf install -y go
git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm

source $HOME/.zshrc
nvm install --lts
