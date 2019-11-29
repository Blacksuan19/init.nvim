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

- [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) (not required but Recommended)
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

| Plugin                                                                  | Functionality                              |
| ----------------------------------------------------------------------- | ------------------------------------------ |
| [vim-airline](https://github.com/vim-airline/vim-airline)               | airline status line                        |
| [airline-themes](https://github.com/vim-airline/vim-airline-themes)     | airline themes                             |
| [devicons](https://github.com/ryanoasis/vim-devicons)                   | icons everywhere                           |
| [rainbow](https://github.com/luochen1990/rainbow)                       | rainbow parenthesis                        |
| [vim-material](https://github.com/hzchirs/vim-material)                 | material themes                            |
| [goyo](https://github.com/junegunn/goyo.vim)                            | focus mode                                 |
| [coc.nvim](https://github.com/neoclide/coc.nvim)                        | async completion and more                  |
| [ale-sensible](https://github.com/desmap/ale-sensible)                  | better ALE experience                      |
| [ale](https://github.com/w0rp/ale)                                      | diagnostics, linting and more              |
| [prettier](https://github.com/prettier/vim-prettier)                    | formatter for many languages               |
| [vim-checbox](https://github.com/jkramer/vim-checkbox)                  | check boxes rendering in markdown          |
| [bullets](https://github.com/dkarter/bullets.vim)                       | better lists in markdown                   |
| [fzf](https://github.com/junegunn/fzf)                                  | fuzzy finder                               |
| [fzf.vim](https://github.com/junegunn/fzf.vim)                          | fuzzy finder vim integration               |
| [ultisnips](https://github.com/SirVer/ultisnips)                        | snippets engine                            |
| [vim-snippets](https://github.com/honza/vim-snippets)                   | snippets for many languages                |
| [auto-pairs](https://github.com/jiangmiao/auto-pairs)                   | auto brackets closing                      |
| [vim-closetag](https://github.com/alvan/vim-closetag)                   | auto html tag closing                      |
| [indentLine](https://github.com/Yggdroot/indentLine)                    | auto indtent lines                         |
| [vim-searchindex](https://github.com/google/vim-searchindex)            | show index of a search string              |
| [vim-polyglot](https://github.com/sheerun/vim-polyglot)                 | add syntax support for many languages      |
| [vim-liquid](https://github.com/tpope/vim-liquid)                       | liquid language support                    |
| [vim-mipssyntax](https://github.com/harenome/vim-mipssyntax)            | mips assembly syntax support               |
| [vim-commentary](https://github.com/tpope/vim-commentary)               | better comments everywhere                 |
| [vim-sensible](https://github.com/tpope/vim-sensible)                   | sensible defaults for vim                  |
| [suda](https://github.com/lambdalisue/suda.vim)                         | add sudo support                           |
| [vim-auto-save](https://github.com/907th/vim-auto-save)                 | auto save on insert mode exit              |
| [vim-startify](https://github.com/mhinz/vim-startify)                   | cool startup thingy                        |
| [vim-carbon-no-sh](https://github.com/kristijanhusak/vim-carbon-now-sh) | cool screen shots powered by carbon now sh |
| [vim-fugitive](https://github.com/tpope/vim-fugitive)                   | best git integration around                |
| [vim-surround](https://github.com/tpope/vim-surround)                   | surround stuff with stuff                  |
| [vim-smoothie](https://github.com/psliwka/vim-smoothie)                 | super smooth scrolling                     |
| [vim-lastplace](https://github.com/farmergreg/vim-lastplace)            | open a file in the last place cursor was   |
| [vim-eunuch](https://github.com/tpope/vim-eunuch)                       | some common Linux commands                 |
| [vim-cool](https://github.com/romainl/vim-cool)                         | better search highlight control            |
| [tmux-complete](https://github.com/wellle/tmux-complete.vim)            | tmux panes completion                      |

## Keyboard shortcuts

## Credits
