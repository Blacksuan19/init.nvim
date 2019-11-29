# An opinionated Neovim config for the Minimalists

## Why?

Modern vim distributions are really huge and bloated with way too many fancy features
that you won't ever use or need, for example directory trees like Nerd tree, you
don't need a tree, you can view a project structure with fzf which is faster and has search.
Another example is [ThinkVim](https://github.com/hardcoreplayers/ThinkVim) has a
separate extension for formatting while also having ALE which can do that as
well, this double functionality is very common, thats one of the things this
distro avoids, KISS!

## Features

- Single file (you don't want your dotfiles to be all vim script)
- Super minimal (~400 lines)
- Super fast startup (less than 40ms!)
- Lazy loading plugins
- Highly customizable
- Beautiful Material ocean color scheme
- VSCode like autocompletion, multi cursor
- Smooth Scrolling (its really smooth!)
- Asynchronous Lint Engine
- Simple, Intuitive shortcuts

### Supported Languages

Neovim provies support for a wide range of languages by default, with the adition
of [polyglot](https://github.com/sheerun/vim-polyglot) even more languages are supported.  
There is also support for:

- [liquid](https://shopify.github.io/liquid/)
- mips assembly

## Requirements

- Linux (not tested on other platforms)
- Neovim (you can try regular vim)
- Properly set up environment

## Setup

to check if your current environment is correctly set up run `:CheckHealth`.

### Enviroment

- python
  - python3 `pip3 install --user pynvim`
  - python2 `pip2 install --user pynvim`
- ruby `gem install neovim`
- nodeJS `yarn install -g neovim`

### Tools

- [tmux](https://github.com/tmux/tmux) (not required but recommended)
- [jedi](https://github.com/davidhalter/jedi-vim)
- [prettier](https://prettier.io/)
- clang (much better C and C++)
- [fuzzy finder (fzf)](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [the silver searcher (Ag)](https://github.com/ggreer/the_silver_searcher)
- [Terminal markdown viewer](https://github.com/axiros/terminal_markdown_viewer)

## Installation

- `git clone https://github.com/Blacksuan19/init.nvim ~/.config/nvim`
- Start `nvim` and it will do the rest

## Plugins

## Keyboard shortcuts

## Credits
