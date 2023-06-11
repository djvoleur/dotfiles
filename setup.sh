#!/bin/bash
dir=$('pwd')
OS=$(uname -a)
export GIT_EDITOR=nvim

if [ -f "/etc/os-release" ]; then
  FLAVOR=$(grep "^ID" /etc/os-release | head -n 1 | cut -d "=" -f 2)
fi

if [[ "$OS" =~ "Linux" ]]; then
  if [ "$FLAVOR" == "fedora" ]; then
    # Setup for neovim
    sudo dnf install -y golang rust-analyzer npm gcc-c++ git fd-find ripgrep cargo \
      python3-pip zsh kitty neovim numix-icon-theme-circle gnome-tweaks budgie-desktop \
      openh264
    sudo dnf update -y
  fi

  if [[ "$FLAVOR" =~ "solus" ]]; then
    sudo eopkg it -c system.devel
    sudo eopkg it -y golang nodejs gcc g++ fd ripgrep pip zsh neovim rustup \
      numix-icon-theme-circle materia-gtk-theme-dark-compact kitty
    rustup default stable
    # Before of installation fails with lock file for neovim
    # Delete files here - ~/.local/share/nvim/mason/staging
    # and retry
    sudo eopkg up
  fi

  if [[ "$FLAVOR" =~ "ubuntu" ]]; then
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update -y
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
    sudo apt install -y build-essential nodejs fd-find ripgrep rust-all zsh neovim \
      python3-pip
    sudo apt upgrade -y
    sudo apt autoremove -y
  fi

  # Setup auto-cpufreq
  git clone https://github.com/AdnanHodzic/auto-cpufreq.git
  cd auto-cpufreq
  sudo ./auto-cpufreq-installer
  cd .. && sudo rm -rf auto-cpufreq
  
  sudo auto-cpufreq --install
  sudo pip install --upgrade pip
  python3 -m pip install pynvim

fi

if [[ "$OS" =~ "Darwin" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install neovim ripgrep fd rust npm kitty
  python3.11 -m pip install --upgrade pip
  python3.11 -m pip install pynvim
  brew update
  brew upgrade
fi

# Setup npm
sudo npm install -g npm@latest
sudo npm install -g neovim
sudo npm install -g tree-sitter-cli

# Setup Powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

mkdir -p $HOME/.config/nvim

rm -f $HOME/.config/nvim/init.lua
ln -s ${dir}/config/nvim/init.lua $HOME/.config/nvim/init.lua

git config --global core.editor "nvim"

# Setup Kitty
rm -f $HOME/.config/kitty/kitty.conf
ln -s ${dir}/config/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

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
