#!/bin/bash

dir=$('pwd')

if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir $HOME/.config/nvim
fi

if [ -L $HOME/.config/nvim/init.lua ] && [ -f $HOME/.config/nvim/init.lua ]; then
  rm -f $HOME/.config/nvim/init.lua
  ln -s ${dir}/.config/nvim/init.lua $HOME/.config/nvim/init.lua
else
  ln -s ${dir}/.config/nvim/init.lua $HOME/.config/nvim/init.lua
fi
