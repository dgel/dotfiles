home = os.getenv("HOME")

vim.g.mapleader = ","
vim.g.python3_host_prog = home .. "/.config/nvim/python3_venv/bin/python3"
vim.cmd([[ syntax enable ]])


-- exrc allows loading local executing local rc files.
vim.o.exrc = true
-- secure disallows the use of :autocmd, shell and write commands in local files
vim.o.secure = true
vim.o.clipboard = "unnamedplus"


-- set history file locations
vim.o.directory = home .. "/.config/nvim/swapfiles//"
vim.o.undodir = home .. "/.config/nvim/undofiles/"
vim.o.undofile = true
vim.o.backupdir = home .. "/.config/nvim/backupfiles//"
vim.o.backup = true

-- color settings
vim.o.termguicolors = true


vim.o.laststatus = 2 -- always display status line
vim.o.number = true -- show line numbers
vim.o.relativenumber = true -- relative line numbering
vim.o.hidden = true -- hide buffers
vim.o.scrolloff = 5 -- always show at least 5 lines around the cursor
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.lazyredraw = true -- redraw only when needed (not while executing macros)

vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.softtabstop=2
vim.o.expandtab = true

vim.o.showmode = false

vim.o.list = true
vim.o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·"

vim.opt.diffopt = vim.opt.diffopt + "vertical"
vim.opt.diffopt = vim.opt.diffopt + "iwhite"
