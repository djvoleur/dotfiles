#!/bin/bash

dir=$('pwd')

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

ln -s ${dir}/.config/nvim/init.lua $HOME/.config/nvim/init.lua
ln -s ${dir}/.config/nvim/after $HOME/.config/nvim/after
ln -s ${dir}/.config/nvim/lua $HOME/.config/nvim/lua
ln -s ${dir}/.config/nvim/plugin $HOME/.config/nvim/plugin
