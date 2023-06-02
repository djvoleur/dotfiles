#!/bin/bash

dir=$('pwd')
OS=$(grep "ID" /etc/os-release | head -n 1 | cut -d "=" -f 2)

if [ "$OS" == "fedora" ]; then
   sudo dnf install -y golang rust-analyzer npm gcc-c++
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir $HOME/.config/nvim
fi

if [ -L $HOME/.config/nvim/init.lua ] && [ -f $HOME/.config/nvim/init.lua ]; then
  rm -f $HOME/.config/nvim/init.lua
  ln -s ${dir}/.config/nvim/init.lua $HOME/.config/nvim/init.lua
else
  ln -s ${dir}/.config/nvim/init.lua $HOME/.config/nvim/init.lua
fi
