#!/bin/bash

# For this repo
git config user.name segcore
git config user.email segcore@github.com
# If none globally, add it globally
if ! git config --global user.name > /dev/null; then
	git config --global user.name "`git config user.name`"
	git config --global user.email "`git config user.email`"
fi

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

ln -svT ~/.dotfiles/git/ ~/.config/git
ln -svT ~/.dotfiles/tmux ~/.config/tmux
ln -svT ~/.dotfiles/kitty ~/.config/kitty

