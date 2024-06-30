#!/bin/bash

# For this repo
git config user.name segcore
git config user.email segcore@github.com

mkdir -p ~/.config

bash_location="~/.dotfiles/bash/custom.sh"
if ! grep -q "$bash_location" ~/.bashrc; then
	echo ". $bash_location" >> ~/.bashrc
fi

# Needs a manual pathname expansion for ~
source "${bash_location/\~/$HOME}"

if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

ln -sT ~/.dotfiles/git/ ~/.config/git
ln -sT ~/.dotfiles/tmux ~/.config/tmux

