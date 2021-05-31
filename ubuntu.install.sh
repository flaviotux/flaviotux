#!/bin/bash

ZSH_CUSTOM=$HOME/.oh-my-zsh

# ZSH
if [ ! -f /bin/zsh ]; then
  echo ""
  echo "============================="
  echo "Installing ZSH"
  echo "============================="
  echo ""

  sudo apt install zsh zsh-syntax-highlighting zsh-autosuggestions -y
fi

# VIM
if [ ! -f /usr/bin/vim ]; then
  echo ""
  echo "============================="
  echo "Installing VIM"
  echo "============================="
  echo ""

  sudo apt install vim -y
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

  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  sudo add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main"
  sudo apt install --no-install-recommends yarn -y
  yarn config set prefix $HOME/.yarn

  echo ""
  echo "============================="
  echo "Installing Yarn dependencies"
  echo "============================="
  echo ""

  sudo apt install gcc g++ make -y
fi

# Write ZSH settings
echo ""
echo "============================="
echo "Finishing ZSH"
echo "============================="
echo ""


curl https://gist.githubusercontent.com/flaviotux/f53f1c67c8c27567f01456c3098bf27f/raw/1bad66683e74b04cba3abcbd8e254ed9a363b87f/.zshrc > $HOME/.zshrc

echo ""
echo "============================="
echo "Setting ZSH default shell"
echo "============================="
echo ""

sudo sed -i "s/\/home\/$USER:\/bin\/bash/\/home\/$USER:\/bin\/zsh/" /etc/passwd
zsh
