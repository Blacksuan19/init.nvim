" ============= Vim-Plug ============== "{{{

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

"}}}

" ================= looks and GUI stuff ================== "{{{
if !exists('g:vscode')
    Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere
    Plug 'luochen1990/rainbow'                              " rainbow parenthesis
    Plug 'hzchirs/vim-material'                             " material color themes
    Plug 'gregsexton/MatchTag'                              " highlight matching html tags
    Plug 'f-person/auto-dark-mode.nvim'                      " auto dark mode
endif

"}}}

" ================= Functionalities ================= "{{{
Plug 'tpope/vim-eunuch'                                 " run common Unix commands inside Vim
Plug 'machakann/vim-sandwich'                           " make sandwiches
Plug 'Jorengarenar/vim-MvVis'                           " move visual selection

if !exists('g:vscode')
    Plug 'unblevable/quick-scope'                           " highlight f-t markers
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " better python
    Plug 'tpope/vim-commentary'                             " better commenting
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP and more
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
    Plug 'junegunn/fzf.vim'                                 " fuzzy search integration
    Plug 'honza/vim-snippets'                               " actual snippets
    Plug 'Yggdroot/indentLine'                              " show indentation lines
    Plug 'mhinz/vim-startify'                               " cool start up screen
    Plug 'tpope/vim-fugitive'                               " git support
    Plug 'psliwka/vim-smoothie'                             " some very smooth ass scrolling
    Plug 'wellle/tmux-complete.vim'                         " complete words from a tmux panes
    Plug 'christoomey/vim-tmux-navigator'                   " seamless vim and tmux navigation
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'memgraph/cypher.vim'
endif
call plug#end()

"}}}

" ==================== general config ======================== "{{{

set termguicolors                                       " Opaque Background
set mouse=a                                             " enable mouse scrolling
set clipboard+=unnamedplus                              " use system clipboard by default
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent     " tab width
set expandtab smarttab                                  " tab key actions
set incsearch ignorecase smartcase hlsearch             " highlight text while searching
set list listchars=trail:»,tab:»-                       " use tab to navigate in list mode
set fillchars+=vert:\▏                                  " requires a patched nerd font (try FiraCode)
set wrap breakindent                                    " wrap long lines to the width set by tw
set encoding=utf-8                                      " text encoding
set number                                              " enable numbers on the left
set relativenumber                                      " current line is 0
set title                                               " tab title as file name
set noshowmode                                          " dont show current mode below statusline
set noshowcmd                                           " to get rid of display of last command
set conceallevel=2                                      " set this so we wont break indentation plugin
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set tw=90                                               " auto wrap lines that are longer than that
set emoji                                               " enable emojis
set history=1000                                        " history limit
set backspace=indent,eol,start                          " sensible backspacing
set undofile                                            " enable persistent undo
set undodir=/tmp                                        " undo temp file directory
set foldlevel=0                                         " open all folds by default
set inccommand=nosplit                                  " visual feedback while substituting
set showtabline=0                                       " always show tabline
set grepprg=rg\ --vimgrep                               " use rg as default grepper

" performance tweaks
set nocursorline
set nocursorcolumn
set scrolljump=5
set lazyredraw
set redrawtime=10000
set synmaxcol=180
set re=1

" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Themeing
if !exists("g:vscode")
    let g:material_style = 'oceanic'
    colorscheme vim-material
endif

hi Pmenu guibg='#00010a' guifg=white                    " popup menu colors
hi Comment gui=italic cterm=italic                      " italic comments
hi Search guibg=#b16286 guifg=#ebdbb2 gui=NONE          " search string highlight color
hi NonText guifg=bg                                     " mask ~ on empty lines
hi clear CursorLineNr                                   " use the theme color for relative number
hi CursorLineNr gui=bold                                " make relative number bold
hi SpellBad guifg=NONE gui=bold,undercurl               " misspelled words

" colors for git (especially the gutter)
hi DiffAdd  guibg=#0f111a guifg=#43a047
hi DiffChange guibg=#0f111a guifg=#fdd835
hi DiffRemoved guibg=#0f111a guifg=#e53935

" coc multi cursor highlight color
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2

"neovim settings
if exists('g:vscode')
    " fix vim-sandwich highlight colors
    highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
    highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
    highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
    highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none

    " fix quick-scope colors
    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
endif
"}}}

" ======================== Plugin Configurations ======================== "{{{

"" built in plugins
let loaded_netrwPlugin = 1                              " disable netrw
let g:omni_sql_no_default_maps = 1                      " disable sql omni completion
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
if glob('~/.python3') != ''
  let g:python3_host_prog = expand('~/.python3/bin/python')
else
  let g:python3_host_prog = systemlist('which python3')[0]
endif

"" coc

" Navigate snippet placeholders using tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-yank',
            \'coc-pairs',
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-yaml',
            \'coc-lists',
            \'coc-snippets',
            \'coc-pyright',
            \'coc-clangd',
            \'coc-prettier',
            \'coc-xml',
            \'coc-syntax',
            \'coc-git',
            \'coc-marketplace',
            \'coc-highlight',
            \'coc-sh',
            \]

" indentLine
let g:indentLine_char_list = ['▏', '¦', '┆', '┊']
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0                         " actually fix the annoying markdown links conversion
let g:indentLine_fileTypeExclude = ['startify']

"" startify
let g:startify_padding_left = 10
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
    \ { 'type': 'dir'       },
    \ { 'type': 'files'     },
    \ { 'type': 'sessions'  },
    \ { 'type': 'bookmarks' },
    \ { 'type': 'commands' },
    \ ]

" bookmark examples
let  g:startify_bookmarks =  [
    \ {'v': '~/.config/nvim'},
    \ {'d': '~/.dotfiles' }
    \ ]

" custom commands
let g:startify_commands = [
    \ {'ch':  ['Health Check', ':checkhealth']},
    \ {'ps': ['Plugins status', ':PlugStatus']},
    \ {'pu': ['Update vim plugins',':PlugUpdate | PlugUpgrade']},
    \ {'uc': ['Update coc Plugins', ':CocUpdate']},
    \ {'h':  ['Help', ':help']},
    \ ]

" custom banner
let g:startify_custom_header = [
 \ '',
 \ '                                                    ▟▙            ',
 \ '                                                    ▝▘            ',
 \ '            ██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '            ██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '            ██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '            ██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '            ▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \ '',
 \ '',
 \]

" rainbow brackets
let g:rainbow_active = 1

" tmux navigator
let g:tmux_navigator_no_mappings = 1

" semshi settings
let g:semshi#error_sign	= v:false                       " let ms python lsp handle this

"" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"

"}}}

" ======================== Commands ============================= "{{{

au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
au FileType help wincmd L                               " open help in vertical split
au BufWritePre * :%s/\s\+$//e                           " remove trailing whitespaces before saving

if !exists('g:vscode')
au CursorHold * silent call CocActionAsync('highlight') " highlight match on cursor hold
" enable spell only if file type is normal text
let spellable = ['markdown', 'gitcommit', 'txt', 'text', 'liquid', 'rst']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif


" coc completion popup
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" startify if no passed argument or all buffers are closed
augroup noargs
    " startify when there is no open buffer left
    autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

    " open startify on start if no argument was passed
    autocmd VimEnter * if argc() == 0 | Startify | endif
augroup END

" fzf if passed argument is a folder
augroup folderarg
    " change working directory to passed directory
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'cd' fnameescape(argv()[0])  | endif

    " start startify (fallback if fzf is closed)
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | Startify  | endif

    " start fzf on passed directory
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'Files ' fnameescape(argv()[0]) | endif
augroup END

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" python renaming and folding
augroup python
    autocmd FileType python nnoremap <leader>rn :Semshi rename <CR>
    autocmd FileType python set foldmethod=syntax
    autocmd FileType python syn sync fromstart
    autocmd FileType python syn region foldImports start='"""' end='"""' fold keepend
augroup end

" format with available file format formatter
command! -nargs=0 Format :call CocAction('format')

" organize imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" files in fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" advanced grep
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

"}}}

" ================== Custom Functions ===================== "{{{

" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" startify file icons
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

" check if last inserted char is a backspace (used by coc pmenu)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" show docs on things with K
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

endif "g:neovim
"}}}

" ======================== Custom Mappings ====================== "{{{

"" the essentials
let mapleader=","
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nnoremap ; :
nmap <leader>w :w<CR>

" new line in normal mode and back
map <Enter> o<ESC>
map <S-Enter> O<ESC>


if exists('g:vscode')
    " essentials
    nmap <leader>q :q<CR>

    " use internal vscode commentary plugin
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
else
    nmap \ <leader>q
    map <F6> :Startify <CR>
    nmap <leader>q :bd<CR>
    map <leader>s :Format<CR>
    nmap <Tab> :bnext<CR>
    nmap <S-Tab> :bprevious<CR>
    noremap <leader>e :PlugInstall<CR>
    noremap <C-q> :q<CR>

    " use a different register for delete and paste
    nnoremap d "_d
    vnoremap d "_d
    vnoremap p "_dP
    nnoremap x "_x

    " emulate windows copy, cut behavior
    vnoremap <LeftRelease> "+y<LeftRelease>
    vnoremap <C-c> "+y<CR>
    vnoremap <C-x> "+d<CR>

    " switch between splits using ctrl + {h,j,k,l}
    inoremap <C-h> <C-\><C-N><C-w>h
    inoremap <C-j> <C-\><C-N><C-w>j
    inoremap <C-k> <C-\><C-N><C-w>k
    inoremap <C-l> <C-\><C-N><C-w>l
    nnoremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " disable hl with 2 esc
    noremap <silent><esc> <esc>:noh<CR><esc>

    " trim white spaces
    nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

    " markdown preview
    au FileType markdown nmap <leader>m :MarkdownPreview<CR>

    "" FZF
    nnoremap <silent> <leader>f :Files<CR>
    nmap <leader>b :Buffers<CR>
    nmap <leader>c :Commands<CR>
    nmap <leader>t :BTags<CR>
    nmap <leader>/ :Rg<CR>
    nmap <leader>gc :Commits<CR>
    nmap <leader>gs :GFiles?<CR>
    nmap <leader>sh :History/<CR>

    " show mapping on all modes with F1
    nmap <F1> <plug>(fzf-maps-n)
    imap <F1> <plug>(fzf-maps-i)
    vmap <F1> <plug>(fzf-maps-x)

    "" coc

    " use tab to navigate snippet placeholders
    inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ?
        \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ check_back_space() ? "\<TAB>" :
        \ coc#refresh()

    let g:coc_snippet_next = '<tab>'

    " use enter to accept completion
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

    " multi cursor shortcuts
    nmap <silent> <C-a> <Plug>(coc-cursors-word)
    xmap <silent> <C-a> <Plug>(coc-cursors-range)

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " other stuff
    nmap <leader>rn <Plug>(coc-rename)
    nmap <leader>o :OR <CR>

    " jump stuff
    nmap <leader>jd <Plug>(coc-definition)
    nmap <leader>jy <Plug>(coc-type-definition)
    nmap <leader>ji <Plug>(coc-implementation)
    nmap <leader>jr <Plug>(coc-references)

    " other coc actions
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    nmap <leader>a <Plug>(coc-codeaction-line)
    xmap <leader>a <Plug>(coc-codeaction-selected)

    " fugitive mappings
    nmap <leader>gd :Gdiffsplit<CR>
    nmap <leader>gb :Git blame<CR>

    " tmux navigator
    nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>

endif " g:vscode
"}}}


" ======================== Additional sourcing ====================== "{{{
if !exists("g:vscode")
source ~/.config/nvim/statusline.vim
endif
"}}}
