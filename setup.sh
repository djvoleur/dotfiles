#!/bin/bash

dir=$('pwd')

if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir $HOME/.config/nvim
fi

ln -s ${dir}/.config/nvim/init.lua $HOME/.config/nvim/init.lua
