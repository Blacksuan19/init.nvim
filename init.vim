
" ============= Vim-Plug ============== "

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,erlang,go"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

" ================= looks and GUI stuff ================== "

Plug 'vim-airline/vim-airline'                          " airline status bar
Plug 'vim-airline/vim-airline-themes'                   " airline themes
Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere
Plug 'luochen1990/rainbow'                              " rainbow paranthesis
Plug 'hzchirs/vim-material'                             " material color themes
Plug 'junegunn/goyo.vim'                                " zen mode

" ================= Functionalities ================= "

" auto completion, lang servers and stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'desmap/ale-sensible' | Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'css', 'less', 'scss', 'json',  'markdown',  'yaml', 'html'] }

" markdown
Plug 'jkramer/vim-checkbox', { 'for': 'markdown' }      " markdown checboxes
Plug 'dkarter/bullets.vim'                              " markdown bullet lists

" search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                                " fuzzy search integration

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'                               " actual snippets

" visual
Plug 'jiangmiao/auto-pairs'                             " auto insert other paranthesis pairs
Plug 'alvan/vim-closetag'                               " auto close html tags
Plug 'Yggdroot/indentLine'                              " show indentation lines
Plug 'google/vim-searchindex'                           " add number of found matching search items

" languages
Plug 'sheerun/vim-polyglot'                             " many languages support
Plug 'tpope/vim-liquid'                                 " liquid language support
Plug 'harenome/vim-mipssyntax'                          " Mips Assembly support

" other
Plug 'tpope/vim-commentary'                             " better commenting
Plug 'tpope/vim-sensible'                               " sensible defaults
Plug 'lambdalisue/suda.vim'                             " save as sudo
Plug '907th/vim-auto-save'                              " auto save changes
Plug 'mhinz/vim-startify'                               " cool start up screen
Plug 'kristijanhusak/vim-carbon-now-sh'                 " lit code screenshots
Plug 'tpope/vim-fugitive'                               " git support
Plug 'tpope/vim-surround'                               " surround stuff with stuff
Plug 'psliwka/vim-smoothie'                             " some very smooth ass scrolling
Plug 'farmergreg/vim-lastplace'                         " open files at the last edited place
Plug 'tpope/vim-eunuch'                                 " run common unix commands inside vim
Plug 'romainl/vim-cool'                                 " disable hl until another search is performed
Plug 'wellle/tmux-complete.vim'                         " complete words from a tmux panes
call plug#end()


" ==================== general config ======================== "

set termguicolors                                       " Opaque Background
set mouse=a                                             " enable mouse scrolling
set clipboard+=unnamedplus                              " use system clipboard by default

" ===================== Other Configurations ===================== "

filetype plugin indent on                               " enable indentations
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent              " tab key actions
set incsearch ignorecase smartcase hlsearch             " highlight text while searching
set list listchars=trail:»,tab:»-                       " use tab to navigate in list mode
set fillchars+=vert:\▏                                  " requires a patched nerd font (try furaCode)
set wrap breakindent                                    " wrap long lines to the width sset by tw
set encoding=utf-8                                      " text encoding
set number                                              " enable numbers on the left
set title                                               " tab title as file file
set conceallevel=2                                      " set this so we womt break indentation plugin
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set tw=80                                               " auto wrap lines that are longer than that
set emoji                                               " enable emojis
let g:indentLine_setConceal = 0                         " actually fix the annoying markdown links conversion
au BufEnter * set fo-=c fo-=r fo-=o                     " stop annying auto commenting on new lines
set undofile                                            " enable persistent undo
set undodir=~/.nvim/tmp                                 " undo temp file directory

" Transparent Background (For i3 and compton)
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

" Python3 VirtualEnv
let g:python3_host_prog = expand('/usr/bin/python3')

" Coloring
let g:material_style='oceanic'
set background=dark
colorscheme vim-material
let g:airline_theme='material'
highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none
hi Search guibg=orange
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" coc multi cursor highlight color
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2


" performance tweaks
set nocursorline
set nocursorcolumn
set scrolljump=5
set lazyredraw
set synmaxcol=180
set re=1

" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" ======================== Plugin Configurations ======================== "

" Airline
let g:airline_powerline_fonts = 0
let g:airline#themes#clean#palette = 1
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create(['%3p%%  ',
            \ g:airline_symbols.linenr .' ', 'linenr', ':%c '])
let g:airline_section_warning = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'        " show only file name on tabs
let g:airline#extensions#ale#enabled = 1                " ALE integration

" coc
" use tab for completion trigger
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" list of the extensions required
let g:coc_global_extensions = [
            \'coc-yank',
            \'coc-highlight',
            \'coc-prettier',
            \'coc-pairs',
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-yaml',
            \'coc-lists',
            \'coc-snippets',
            \'coc-ultisnips',
            \'coc-python',
            \'coc-xml',
            \'coc-word',
            \'coc-syntax',
            \'coc-emoji',
            \'coc-git',
            \]

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'c' : ['clang-format'],
\   'cpp' : ['clang-format'],
\   'mips' : ['gcc'],
\   'css' : ['prettier'],
\   'html' : ['prettier'],
\   'markdown' : ['prettier'],
\}
let g:ale_fix_on_save = 1

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

" fzf-vim
let g:FZF_DEFAULT_COMMAND = 'rg --hidden --ignore .git -g ""'
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'Type'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Character'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" startify
let g:startify_session_persistence = 1

" auto save file changes
let g:auto_save = 1                                     " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1                       " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0                      " do not save while in insert mode
let g:auto_save_silent = 1

" rainbow brackets
let g:rainbow_active = 1


" ======================== Filetype-Specific Configurations ============================= "


" HTML, XML, Css
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown set spell
autocmd FileType markdown map <silent> <leader>m :call TerminalPreviewMarkdown()<CR>

" config files
au BufReadPost,BufNewFile */polybar/* set filetype=dosini
au BufReadPost,BufNewFile */termite/* set filetype=dosini

" startify when there is no buffer (file open)
autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

" auto html tags closing, enable for markdown files as well
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.md'

" mips assembly files
autocmd BufReadPost,BufNewFile *.S set filetype=mips

" disable autosave on kernel directory and also formatting on save (we dont wanna fuck this up)
autocmd BufRead,BufNewFile */Dark-Ages/* let b:auto_save = 0
autocmd BufRead,BufNewFile */Dark-Ages/* let b:ale_fix_on_save = 0

" ================== Custom Functions ===================== "

" start startify if there are no args()
function! StartUp()
    if 0 == argc()
        Startify
    end
endfunction

autocmd VimEnter * call StartUp()

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

" markdown files preview inside (you need to install mdv)
function! TerminalPreviewMarkdown()
    vsp | terminal ! mdv %
endfu

" tabs manipulation
function! Rotate() " switch between horizontal and vertical split mode for open splits
    " save the original position, jump to the first window
    let initial = winnr()
    exe 1 . "wincmd w"

    wincmd l
    if winnr() != 1
        " succeeded moving to the right window
        wincmd J                " make it the bot window
    else
        " cannot move to the right, so we are at the top
        wincmd H                " make it the left window
    endif

    " restore cursor to the initial window
    exe initial . "wincmd w"
endfunction

nnoremap <F5> :call Rotate()<CR>

" ======================== Custom Mappings ====================== "

" the essentials
let mapleader=","
nnoremap ; :
nmap \ <leader>q
map <F6> :Startify <CR>
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>t :call TrimWhitespace()<CR>
nmap <leader>q :bd<CR>
nmap <leader>w :w<CR>
nmap <leader>f :Files<CR>
nmap <leader>g :Goyo<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <leader>e :PlugInstall<CR>
noremap <C-q> :q<CR>
inoremap jj <ESC>

" use a different buffer for dd
nnoremap d "_d
vnoremap d "_d

" emulate windows copy, cut behavior
vnoremap <LeftRelease> "+y<LeftRelease>
vnoremap <C-c> "+y<CR>
vnoremap <C-x> "+d<CR>

" switch between splits using ctrl + {h,j,k,l}
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
noremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" multi cursor shortcuts
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-a> <Plug>(coc-cursors-word)
xmap <silent> <C-a> <Plug>(coc-cursors-range)

" new line in normal mode and back
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" for project wide search
map <leader>/ :Ag<CR>

" carbon sh now
vnoremap <F8> :CarbonNowSh<CR>
