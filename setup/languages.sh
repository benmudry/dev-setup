#!/bin/zsh

sudo dnf install -y go

sudo dnf copr enable jdxcode/mise
sudo dnf install mise

echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source $HOME/.zshrc
mise use --global node@lts

# git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
#
# source $HOME/.zshrc
# nvm install --lts
