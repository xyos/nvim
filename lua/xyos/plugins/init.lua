return {
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = function()
      require("neoconf").setup({
        -- Configuration here, or leave empty to defaults
      })
    end,
  },
}
