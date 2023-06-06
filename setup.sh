#!/bin/bash
dir=$('pwd')
OS=$(grep "ID" /etc/os-release | head -n 1 | cut -d "=" -f 2)
export GIT_EDITOR=nvim

if [ "$OS" == "fedora" ]; then
  # Setup for neovim
  sudo dnf install -y golang rust-analyzer npm gcc-c++ git fd-find ripgrep cargo python3-pip zsh kitty neovim
  /usr/bin/python3 -m pip install pynvim
  sudo npm install -g npm@9.6.7
  sudo npm install -g neovim
  sudo npm install -g tree-sitter-cli
fi

if [[ "$OS" =~ "solus" ]]; then
  sudo eopkg it -c system.devel
  sudo eopkg it -y golang nodejs gcc g++ fd ripgrep pip zsh neovim rustup numix-icon-theme-circle materia-gtk-theme-dark-compact
  rustup default stable
  sudo pip install --upgrade pip
  /usr/bin/python3 -m pip install pynvim
  sudo npm install -g npm@9.6.7
  sudo npm install -g neovim
  sudo npm install -g tree-sitter-cli
  # Before of installation fails with lock file for neovim
  # Delete files here - ~/.local/share/nvim/mason/staging
  # and retry
fi

mkdir -p $HOME/.config/nvim

rm -f $HOME/.config/nvim/init.lua
ln -s ${dir}/config/nvim/init.lua $HOME/.config/nvim/init.lua

git config --global core.editor "nvim"

# Setup oh-my-zsh
rm -f $HOME/.zshrc
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.zshrc.pre-oh-my-zsh*
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm -f $HOME/.zshrc
ln -s ${dir}/config/.zshrc $HOME/.zshrc

# Setup zsh-autosuggestions
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
