return {
  "p00f/nvim-ts-rainbow",
  "lukas-reineke/indent-blankline.nvim",
  "nvim-lualine/lualine.nvim",
  "luukvbaal/statuscol.nvim",
  "folke/which-key.nvim",
  "mbbill/undotree",
  "theprimeagen/harpoon",
  "akinsho/toggleterm.nvim", -- terminal
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
