[Go back to README](README.md)

## Installation

**Important**: The instructions were primarily written during the initial installation. It is difficult to keep this script and list of install tools up-to-date, so there may be missing or incorrect steps. Any PR's or issues are welcome if you find something in this section.

### Fedora

#### Step 1: Installation script (or manual installation based off of script)

:warning::warning: THIS SCRIPT IS NO LONGER SUPPORTED :warning::warning:

**This installation script can provide a rough guideline for getting the project set up, but it no longer successfully runs and is difficult to test and support**

<details>
  <summary>Click to see unsupported install script instructions</summary>


  Clone Jarvis into your directory of choice and run the install script. This script will install [Homebrew](https://brew.sh/) (if it needs to) and then install all of Jarvis' dependencies.

  **Warning: This will move existing `zsh`, `tmux`, or `nvim` configurations to a backup folder inside of the installation repo.**

  ```bash
  git clone https://github.com/ribeirof7x/ribeirof7x ~/nvim-config
  cd ~/nvim-config
  ./install.fedora.sh
  ```
</details>

Alternatively, you can use the `install.fedora.sh` script as a guide for installing the required libraries/plugins and do it manually yourself (safest option).

#### Step 2: Manually Install Additional Tools

The following tools are the only ones that are (currently) required to be installed manually.

1. (Optional) Depending on your autocomplete needs with [coc.nvim](https://github.com/neoclide/coc.nvim), you will want to install the appropriate langague servers. For example, I use the following extensions:
  - [Typescript/Javascript](https://github.com/neoclide/coc-tsserver): `:CocInstall coc-tsserver`
  - [Eslint](https://github.com/neoclide/coc-eslint): `:CocInstall coc-eslint`
  - [Prettier](https://github.com/neoclide/coc-prettier): `:CocInstall coc-prettier`
  - [CSS](https://github.com/neoclide/coc-css): `:CocInstall coc-css`
  - [json](https://github.com/neoclide/coc-json): `:CocInstall coc-json`

**Installed Tools**

1. [Tmux](https://github.com/tmux/tmux/wiki) - Terminal multiplexer with session management, customizable terminal layouts, and much more.
2. [NeoVim](https://github.com/neovim/neovim) - A fork of Vim that was created to be a community-driven rewrite of Vim that is focused on cleaning up the codebase and providing a way for developers to contribute to the advancement of the editor. For a list of all the plugins installed for Neovim, see the [plugins file](config/nvim/plugins.vim).
3. [Python 3](https://www.python.org/downloads/)/[Python Neovim Client](https://github.com/neovim/python-client) - Implements support for python plugins in Neovim.
4. [ripgrep](https://github.com/BurntSushi/ripgrep) - A blazingly fast line-oriented search tool that respects .gitignore rules.
5. [fzf](https://github.com/junegunn/fzf#installation) - A general-purpose command-line fuzzy finder that can be used with any list; files, command history, processes, hostnames, bookmarks, git commits, etc.
6. [z](https://github.com/rupa/z) - Tracks your most used directories and lets you quickly hop there with regexes.
7. [Fira Code font](https://github.com/tonsky/FiraCode/wiki/Linux-instructions#fedora) - Custom fonts with ligatures added for NeoVim.
8. [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) - Installs and loads tmux plugins.

