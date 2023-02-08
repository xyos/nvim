local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("mason-nvim-dap").setup({
    ensure_installed = { "chrome", "firefox", "node2" },
    automatic_setup = true,
})

-- dap.configurations.javascript = {
--     {
--       type = "chrome",
--       request = "launch",
--       program = "${workspaceFolder}/${file}",
--       cwd = vim.fn.getcwd(),
--       sourceMaps = true,
--       protocol = "inspector",
--       console = "integratedTerminal",
--     },
--   }
-- dap.configurations.typescript = dap.configurations.javascript
require 'mason-nvim-dap'.setup_handlers {
    function(source_name)
      -- all sources with no handler get passed here
      -- Keep original functionality of `automatic_setup = true`
      require('mason-nvim-dap.automatic_setup')(source_name)
    end,
}
