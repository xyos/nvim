vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR=1")

vim.opt.termguicolors = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

vim.opt.listchars = {
  eol = '¬',
  space = ' ',
  nbsp = '␣',
  trail = '·',
  tab = '→ ',
  extends = '›',
  precedes = '‹',
}

vim.opt.shell = '/bin/bash'
vim.opt.showbreak = '↪'
vim.opt.list = true

vim.opt.completeopt:append("menuone")
vim.opt.completeopt:append("noselect")
vim.opt.completeopt:remove("preview")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

vim.wo.linebreak = true
vim.wo.breakindent = true

vim.opt.shiftwidth = 2; vim.bo.shiftwidth = 2
vim.opt.tabstop = 2; vim.bo.tabstop = 2
vim.opt.softtabstop = 2; vim.bo.softtabstop = 2
vim.opt.expandtab = true; vim.bo.expandtab = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = 'a'

vim.opt.laststatus = 3 -- only one status line

vim.opt.guicursor = ""
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
