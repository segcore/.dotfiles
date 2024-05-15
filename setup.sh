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

ln -sT ~/.dotfiles/git/ ~/.config/git
ln -sT ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

