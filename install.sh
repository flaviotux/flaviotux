#!/bin/sh
echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Greetings. Preparing to power up and begin diagnostics.$(tput sgr 0)"
echo "---------------------------------------------------------"
ZSH_CUSTOM=$HOME/.oh-my-zsh

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing system packages.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo dnf install git alacritty tmux neovim python3 zsh zsh-syntax-highlighting zsh-autosuggestions exa starship ripgrep fzf z gcc-c++ make -y

if [ -d "$HOME/.nvm" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: NVM is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing NVM.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Checking for tmux-plugins tpm installation.$(tput sgr 0)"
echo "--------------------------------------------------------"
if [ -d "$HOME/.tmux" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: tmux-plugins tpm is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing tmux-plugins tpm.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Checking for Yarn installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
if [ -f "/usr/bin/yarn" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: Yarn is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing Yarn.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
  sudo dnf install yarn -y
  yarn config set prefix $HOME/.yarn
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing FiraMono Nerd Font.$(tput sgr 0)"
echo "---------------------------------------------------------"
mkdir -p ~/.local/share/fonts/OTF/FiraMonoNerdFont/
curl -fLo ~/.local/share/fonts/OTF/FiraMonoNerdFont/FiraMonoNerdFont-Regular.otf  https://github.com/ryanoasis/nerd-fonts/raw/v2.1.0/patched-fonts/FiraMono/Regular/complete/Fira%20Mono%20Regular%20Nerd%20Font%20Complete.otf

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing Python NeoVim client.$(tput sgr 0)"
echo "---------------------------------------------------------"
pip3 install neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing node neovim package$(tput sgr 0)"
echo "---------------------------------------------------------"
yarn global add neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing vim linter (vint)$(tput sgr 0)"
echo "---------------------------------------------------------"
pip3 install vim-vint

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing bash language server$(tput sgr 0)"
echo "---------------------------------------------------------"
yarn global add bash-language-server

# Create backup folder if it doesn't exist
mkdir -p ~/.local/share/nvim/backup

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: Installing oh-my-zsh.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: oh-my-zsh already installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
fi

if [ -d "$HOME/.tmux" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: tmux plugins already installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: Installing tmux plugins.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Checking for pyenv installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
if [ -d "$HOME/.pyenv" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: pyenv is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing pyenv.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  curl https://pyenv.run | bash
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Checking for Homebrew installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: Homebrew is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing Homebrew.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  CI=1 curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing Homebrew dependencies.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  sudo dnf groupinstall 'Development Tools'
  sudo dnf install procps-ng curl file git
  sudo dnf install libxcrypt-compat # needed by Fedora 30 and up
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing Neovim plugins and linking dotfiles.$(tput sgr 0)"
echo "---------------------------------------------------------"
source install/backup.sh
source install/link.sh
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Switching shell to zsh. You may need to logout.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo sh -c "echo $(which zsh) >> /etc/shells"
sudo sed -i "s/\/home\/$USER:\/bin\/bash/\/home\/$USER:\/bin\/zsh/" /etc/passwd

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: System update complete. Currently running at 100% power. Enjoy.$(tput sgr 0)"
echo "---------------------------------------------------------"
exit 0
