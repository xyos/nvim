require('toggleterm').setup({ cmd = 'fish' })

local Terminal  = require('toggleterm.terminal').Terminal

local bottom = Terminal:new({ direction = 'horizontal', size = 15, cmd = 'fish' })

function _G.__bterm_toggle()
  bottom:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>lua __bterm_toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<leader>1', '<C-\\><C-n><cmd>lua __bterm_toggle()<CR>', { noremap = true, silent = true })

local float = Terminal:new({
  cmd = 'fish',
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    width = 100,
    height = 30,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
})

function _G.__fterm_toggle()
  float:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>`', '<cmd> lua __fterm_toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<leader>`', '<C-\\><C-n><cmd> lua __fterm_toggle()<CR>', { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-c>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
