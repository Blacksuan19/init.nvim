# An opinionated Neovim config for the Minimalists

## Table of Contents

- [Why?](#why)
- [Features](#features)
  - [Supported Languages](#supported-languages)
- [Requirements](#requirements)
- [Setup](#setup)
  - [Enviroment](#Environment)
  - [Tools](#tools)
- [Installation](#installation)
- [Plugins](#plugins)
- [Keyboard shortcuts](#keyboard-shortcuts)
  - [FZF](#fzf-keyboard-shortcuts)
- [Customizations](#customizations)
- [Demos](#demos)
- [Credits](#credits)

## Why?

Modern Vim distributions are really huge and bloated with way too many fancy features
that you won't ever use or need, for example directory trees like Nerd tree, you
don't need a tree, you can view a project structure with fzf which is faster and has search.
Another example is [ThinkVim](https://github.com/hardcoreplayers/ThinkVim) has a
separate extension for formatting while also having ALE which can do that as
well, this double functionality is very common, thats one of the things this
distro avoids, KISS!

## Features

- Single file (you don't want your dotfiles to be all Vim script)
- Super minimal (~400 lines)
- Super fast startup (less than 40ms!)
- Lazy loading plugins
- Highly customizable
- Beautiful Material ocean color scheme
- Vscode like auto completion, multi cursor
- Smooth Scrolling (its really smooth!)
- floating window + borders + file previews on fzf(see [demos](#demos))
- Asynchronous Lint Engine
- Simple, Intuitive shortcuts

### Supported Languages

Neovim provides support for a wide range of languages by default.
There is also support for:

- [liquid](https://shopify.github.io/liquid/)
- [dart](https://dark.dev)

## Requirements

- Linux (not tested on other platforms)
- Neovim (you can try regular Vim)
- Properly set up environment

## Setup

To check if your current environment is correctly set up run `:CheckHealth`.

### Environment

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
- [bat](https://github.com/sharkdp/bat)

## Installation

After installing the requirements:

- `git clone https://github.com/Blacksuan19/init.nvim ~/.config/nvim`
- Start `nvim` and it will do the rest
- press enter if there are any errors (don't worry its fine)

## Plugins

Thanks to vim-plug the plugins are lazy loaded (anything that is not needed for
the current buffer is not loaded) for example opening a python file means all
other non python related plugins are not loaded.  
Coc extensions are lazy loaded as well, they work the same way as vim-plug plugins.

| Plugin                                                                  | Functionality                                 |
| ----------------------------------------------------------------------- | --------------------------------------------- |
| [vim-airline](https://github.com/vim-airline/vim-airline)               | airline status line                           |
| [airline-themes](https://github.com/vim-airline/vim-airline-themes)     | airline themes                                |
| [devicons](https://github.com/ryanoasis/vim-devicons)                   | icons everywhere                              |
| [rainbow](https://github.com/luochen1990/rainbow)                       | rainbow parenthesis                           |
| [vim-material](https://github.com/hzchirs/vim-material)                 | material themes                               |
| [goyo](https://github.com/junegunn/goyo.vim)                            | focus mode                                    |
| [coc.nvim](https://github.com/neoclide/coc.nvim)                        | async completion and more                     |
| [ale-sensible](https://github.com/desmap/ale-sensible)                  | better ALE experience                         |
| [ale](https://github.com/w0rp/ale)                                      | diagnostics, linting and more                 |
| [fzf](https://github.com/junegunn/fzf)                                  | fuzzy finder                                  |
| [fzf.vim](https://github.com/junegunn/fzf.vim)                          | fuzzy finder vim integration                  |
| [ultisnips](https://github.com/SirVer/ultisnips)                        | snippets engine                               |
| [vim-snippets](https://github.com/honza/vim-snippets)                   | snippets for many languages                   |
| [vim-closetag](https://github.com/alvan/vim-closetag)                   | auto html tag closing                         |
| [indentLine](https://github.com/Yggdroot/indentLine)                    | auto indent lines                             |
| [vim-searchindex](https://github.com/google/vim-searchindex)            | show index of a search string                 |
| [vim-liquid](https://github.com/tpope/vim-liquid)                       | liquid language support                       |
| [dart-vim-plugin](https://github.com/dart-lang/dart-vim-plugin)         | dart language support                         |
| [vim-commentary](https://github.com/tpope/vim-commentary)               | better comments everywhere                    |
| [vim-sensible](https://github.com/tpope/vim-sensible)                   | sensible defaults for vim                     |
| [suda](https://github.com/lambdalisue/suda.vim)                         | add sudo support                              |
| [vim-auto-save](https://github.com/907th/vim-auto-save)                 | auto save on insert mode exit                 |
| [vim-startify](https://github.com/mhinz/vim-startify)                   | cool startup thingy                           |
| [vim-carbon-no-sh](https://github.com/kristijanhusak/vim-carbon-now-sh) | cool screen shots powered by carbon now sh    |
| [vim-fugitive](https://github.com/tpope/vim-fugitive)                   | best git integration around                   |
| [vim-sandwich](https://github.com/machakann/vim-sandwich)               | surround stuff with stuff                     |
| [vim-smoothie](https://github.com/psliwka/vim-smoothie)                 | super smooth scrolling                        |
| [vim-lastplace](https://github.com/farmergreg/vim-lastplace)            | open a file in the last place cursor was      |
| [vim-cool](https://github.com/romainl/vim-cool)                         | better search highlight control               |
| [tmux-complete](https://github.com/wellle/tmux-complete.vim)            | tmux panes completion                         |
| [Vista](https://github.com/liuchengxu/vista.vim)                        | list of tags                                  |
| [vim-eunuch](https://github.com/tpope/vim-eunuch)                       | some common Linux commands                    |
| [fzf-preview](https://github.com/yuki-ycino/fzf-preview.vim)            | fzf floating windows with previews everywhere |

## Keyboard shortcuts

To learn the default Vim shortcuts run `Tutor` and or checkout this [site](https://vim-adventures.com/).  
Not a lot of changes have been done here, the plugins shortcuts are almost
identical, check each plugin under the [plugins](#plugins) section for its key
mappings, the changes i have made either make a function easier to access and or
expose a hidden functionality within a plugin.

#### Legend

`,` == leader key  
`S` == Shift key  
`C` == ctrl key

| Mapping | functionality                                                              | Replaced Mapping |
| ------- | -------------------------------------------------------------------------- | ---------------- |
| `;`     | commands key                                                               | :                |
| `,r`    | reload Nvim config                                                         | None             |
| `,t`    | Trim white spaces(enabled by default with ALE)                             | None             |
| `,q`    | close tab                                                                  | :q               |
| `,w`    | save changes(tho save when existing insert mode is enabled by default)     | :q               |
| `,f`    | fzf files viewer (shows project files with the ability to search)          | None             |
| `,g`    | Goyo (zen mode)                                                            | Default          |
| `,e`    | call :PlugInstall (install plugins)                                        | None             |
| `,v`    | search in vista tags                                                       | None             |
| `,c`    | show git status in fzf                                                     | None             |
| `,/`    | search in project folder (calls Rg)                                        | None             |
| `,rn`   | rename globally                                                            | None             |
| `,l`    | easymotion to the left                                                     | None             |
| `,h`    | easymotion to the right                                                    | None             |
| `,j`    | easymotion to the bottom                                                   | None             |
| `,k`    | easymotion to the top                                                      | None             |
| `jj`    | Escape                                                                     | Esc              |
| `d`     | use a different register for deletion (so the deleted text wont be copied) | "\_d             |
| `C-q`   | close all buffers and exit nvim                                            | None             |
| `C-c`   | copy text to system clipboard (only in visual mode)                        | +y               |
| `C-x`   | cut text to system clipboard (only in visual mode)                         | +d               |
| `C-l`   | move to the split on the right                                             | Default          |
| `C-k`   | move the split above                                                       | Default          |
| `C-j`   | move to the split on below                                                 | Default          |
| `C-h`   | Move the split to the left                                                 | Default          |
| `C-c`   | highlights character for multi cursor selection (in normal mode)           | None             |
| `C-a`   | Highlights word/selection for multi cursor selection                       | None             |
| `ENTER` | insert blank line below in normal mode                                     | None             |
| `ENTER` | inputs selected snippet in insert mode                                     | None             |
| `Tab`   | cycles throw coc in insert mode                                            | None             |
| `Tab`   | switch to the next buffer(tab)                                             | Default          |
| `S-Tab` | switch to the previous buffer(tab)                                         | Default          |
| `F4`    | Open vista (tags viewer)                                                   | none             |
| `F6`    | Startify                                                                   | Default          |
| `F8`    | opens selection in carbon now sh (only in visual mode)                     | None             |
| `]g`    | next diagnostic                                                            | None             |
| `[g`    | Previous diagnostic                                                        | None             |
| `gd`    | jump to definition(using coc)                                              | None             |
| `gy`    | jump to type definition(using coc)                                         | None             |
| `gi`    | jump to implementation(using coc)                                          | None             |
| `gr`    | jump to references (using coc)                                             | None             |
| `S-k`   | show current symbol documentation                                          | None             |

### FZF keyboard shortcuts

| Mapping | Functionality                             |
| ------- | ----------------------------------------- |
| `C-x`   | Open file in horizontal split             |
| `C-v`   | Open file in vertical split               |
| `C-t`   | Open file in new tab                      |
| `C-d`   | scroll preview down (like in normal mode) |
| `C-u`   | Scroll preview up                         |
| `?`     | turn off/on preview                       |

## Customizations

Since the file is pretty small its very easy to interpret by even those who
don't have any knowledge about vim script, most of the sections have comments
about their functionality, and can be removed, commented out or swapped easily,
there are some defaults that are not everyone's cup of tea (after all this is
highly opinionated).

- _Disabling autosave:_ set `let g:auto_save = 0`
- _Disabling format on save:_ set `let g:ale_fix_on_save = 0`
- _removing words from completion:_ `CocList extensions` highlight extension then press Tab to show
  actions

Most of the included plugins are highly customizable in nature (this is vim),
checkout [Plugins](#plugins)

## Demos

![fzf preview](https://github.com/Blacksuan19/init.nvim/blob/master/Screens/fzf.png)
![Ag preview](https://github.com/Blacksuan19/init.nvim/blob/master/Screens/ag.png)
[![asciicast](https://asciinema.org/a/284399.svg)](https://asciinema.org/a/284399)
[![asciicast](https://asciinema.org/a/284400.svg)](https://asciinema.org/a/284400)
[![asciicast](https://asciinema.org/a/284401.svg)](https://asciinema.org/a/284401)

## Credits

All the Credit goes to the Neovim team for making most of the extensions
possible and better (async), and to all the plugins developers, and the hacker
who spend time Finding good shortcuts and tricks to make this an even more
superb experience.
