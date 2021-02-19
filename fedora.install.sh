#!/bin/bash

ZSH_CUSTOM=$HOME/.oh-my-zsh

# ZSH
if [ ! -f /bin/zsh ]; then
  echo ""
  echo "============================="
  echo "Installing ZSH"
  echo "============================="
  echo ""

  sudo dnf install zsh zsh-syntax-highlighting zsh-autosuggestions -y
fi

# VIM
if [ ! -f /usr/bin/vim ]; then
  echo ""
  echo "============================="
  echo "Installing VIM"
  echo "============================="
  echo ""

  sudo dnf install vim -y
fi

# Oh My ZSH
if [ ! -x $HOME/.oh-my-zsh ]; then
  echo ""
  echo "============================="
  echo "Installing Oh My ZSH!"
  echo "============================="
  echo ""

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  echo ""
  echo "============================="
  echo "Installing Spaceship ZSH theme"
  echo "============================="
  echo ""

  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

# Node.js
if [ ! -x $HOME/.nvm ]; then
  echo ""
  echo "============================="
  echo "Installing Node.js"
  echo "============================="
  echo ""

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | zsh
fi

# Yarn
if [ ! -f /usr/bin/yarn ]; then
  echo ""
  echo "============================="
  echo "Installing Yarn"
  echo "============================="
  echo ""

  curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
  sudo dnf --setopt=install_weak_deps=False install yarn -y
  yarn config set prefix $HOME/.yarn

  echo ""
  echo "============================="
  echo "Installing Yarn dependencies"
  echo "============================="
  echo ""

  sudo dnf install gcc-c++ make -y
fi

# Write ZSH settings
echo ""
echo "============================="
echo "Finishing ZSH"
echo "============================="
echo ""


curl https://gist.githubusercontent.com/ribeirof7x/f53f1c67c8c27567f01456c3098bf27f/raw/89a29fb30e6f954cdb04d53e07943d5e685a8974/.zshrc > $HOME/.zshrc

echo ""
echo "============================="
echo "Setting ZSH default shell"
echo "============================="
echo ""

sudo sed -i "s/\/home\/$USER:\/bin\/bash/\/home\/$USER:\/bin\/zsh/" /etc/passwd
zsh
