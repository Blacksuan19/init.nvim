local opt = vim.opt

opt.termguicolors = true
opt.mouse = "a"
opt.clipboard:append("unnamedplus")
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true
opt.smarttab = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.list = true
opt.listchars = "trail:»,tab:»-"
opt.fillchars:append({ vert = "▏" })
opt.wrap = true
opt.breakindent = true
opt.encoding = "utf-8"
opt.number = true
opt.relativenumber = true
opt.title = true
opt.showmode = false
opt.showcmd = false
opt.conceallevel = 2
opt.splitright = true
opt.splitbelow = true
opt.textwidth = 90
opt.emoji = true
opt.history = 1000
opt.backspace = "indent,eol,start"
opt.undofile = true
opt.undodir = "/tmp"
opt.foldlevel = 0
opt.inccommand = "nosplit"
opt.showtabline = 0
opt.grepprg = "rg --vimgrep"

opt.cursorline = false
opt.cursorcolumn = false
opt.scrolljump = 5
opt.lazyredraw = false
opt.redrawtime = 10000
opt.synmaxcol = 180
opt.re = 1

opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.cmdheight = 1
opt.updatetime = 300
opt.shortmess:append("c")
opt.shortmess:append("I")
opt.signcolumn = "yes"
