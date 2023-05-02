return {
  "tpope/vim-commentary", -- comment utilities
  "tpope/vim-sleuth", -- detect ident
  "tpope/vim-repeat", -- add . support to multiple commands
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to defaults
      })
    end,
  },
  "mattn/emmet-vim", -- emmet support
  "andymass/vim-matchup", -- matcher for %
}
