return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        debounce = 100,
        auto_trigger = true,
        keymap = {
          accept = "<C-CR>",
          decline = "<M-x>",
          prev = "<M-[>",
          next = "<M-]>",
        },
      }
    })
  end,
}
