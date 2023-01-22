vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.keymap.set("n", "<Leader>tt", ":Neotree float filesystem reveal_force_cwd<cr>", {noremap = true, silent = true})
vim.keymap.set("n", "<Leader>tg", ":Neotree float git_status<cr>", {noremap = true, silent = true})
vim.keymap.set("n", "<Leader>tb", ":Neotree float buffers<cr>", {noremap = true, silent = true})
