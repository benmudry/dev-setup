#!/bin/bash

rm -rf ~/.config/nvim
cp -r env/.config/personal ~/.config/personal
cp -r env/.config/nvim ~/.config/nvim
cp -r env/.config/tmux ~/.config/tmux
cp -r env/.config/rofi ~/.config/rofi

cp ./tmux-sessionizer/tmux-sessionizer $HOME/.local/scripts/tmux-sessionizer
cp ./env/.zsh_profile $HOME/.zsh_profile
cp ./env/.zshrc $HOME/.zshrc
cp ./env/.tmux-sessionizer $HOME/.tmux-sessionizer

. $HOME/.zsh_profile
. $HOME/.zshrc
