#!/bin/bash
dir=$('pwd')
OS=$(grep "ID" /etc/os-release | head -n 1 | cut -d "=" -f 2)
export GIT_EDITOR=nvim

if [ "$OS" == "fedora" ]; then
  # Setup for neovim
  sudo dnf install -y golang rust-analyzer npm gcc-c++ git fd-find ripgrep cargo python3-pip zsh
  /usr/bin/python3 -m pip install pynvim
fi
# Setup zsh-autosuggestions
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

mkdir -p $HOME/.config/nvim

rm -f $HOME/.config/nvim/init.lua
rm -f $HOME/.zshrc
ln -s ${dir}/config/nvim/init.lua $HOME/.config/nvim/init.lua
ln -s ${dir}/.zshrc $HOME/.zshrc

git config --global core.editor "nvim"
