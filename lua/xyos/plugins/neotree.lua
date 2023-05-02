return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    {
      -- only needed if you want to the "open_window_picker" command
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup({
          version = "v1.*",
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal" },
            },
          },
          other_win_hl_color = "#e35e4f",
        })
      end,
    },
  },
}
