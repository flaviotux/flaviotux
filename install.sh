#!/bin/sh
echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Greetings. Preparing to power up and begin diagnostics.$(tput sgr 0)"
echo "---------------------------------------------------------"
ZSH_CUSTOM=$HOME/.oh-my-zsh

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing system packages.$(tput sgr 0)"
echo "---------------------------------------------------------"
sudo apt install nodejs git tmux neovim python3 zsh zsh-syntax-highlighting zsh-autosuggestions ripgrep fzf gcc g++ make -y

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Checking for Z Script installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
if [ -f "$HOME/.z.sh" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: Z Script is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing Z script.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  wget https://raw.githubusercontent.com/rupa/z/v1.11/z.sh -O ~/.z.sh
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Checking for starship prompt installation.$(tput sgr 0)"
echo "--------------------------------------------------------"
if [ -f "/usr/local/bin/starship" ]; then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Alfred: starship prompt is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 3)Alfred: Installing starship prompt.$(tput sgr 0)"
  echo "---------------------------------------------------------"
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
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
echo "$(tput setaf 2)Alfred: Checking for NVM installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
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
  npm i --global yarn
  yarn config set prefix $HOME/.yarn
fi

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

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Creating NVIM backup directory.$(tput sgr 0)"
echo "---------------------------------------------------------"
mkdir -p ~/.local/share/nvim/backup

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Checking for oh-my-zsh installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
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

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing FiraMono Nerd Font.$(tput sgr 0)"
echo "---------------------------------------------------------"
mkdir -p ~/.local/share/fonts/OTF/FiraMonoNerdFont/
curl -fLo ~/.local/share/fonts/OTF/FiraMonoNerdFont/FiraMonoNerdFont-Regular.otf  https://github.com/ryanoasis/nerd-fonts/raw/v2.1.0/patched-fonts/FiraMono/Regular/complete/Fira%20Mono%20Regular%20Nerd%20Font%20Complete.otf

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing vtop.$(tput sgr 0)"
echo "---------------------------------------------------------"
yarn global add vtop

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Alfred: Installing Neovim plugins and linking dotfiles.$(tput sgr 0)"
echo "---------------------------------------------------------"
bash install/backup.sh
bash install/link.sh
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
