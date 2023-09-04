return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/neodev.nvim",
			config = function()
				require("neodev").setup()
			end,
		},
		"mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	---@class PluginLspOpts
	opts = {
		-- options for vim.diagnostic.config()
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = { spacing = 4, prefix = "●" },
			severity_sort = true,
		},
		-- Inline hints
		inlay_hints = { enabled = true },
		-- Automatically format on save
		autoformat = false,
		-- options for vim.lsp.buf.format
		-- `bufnr` and `filter` is handled by the LazyVim formatter,
		-- but can be also overridden when specified
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		-- LSP Server Settings
		---@type lspconfig.options
		servers = {
			jsonls = {},
			volar = {
				filetypes = { "vue", "javascript", "javascriptreact", "typescript", "typescriptreact" },
				settings = {
					inlay_hints = {},
				},
			},
			lua_ls = {
				-- mason = false, -- set to false if you don't want this server to be installed with mason
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						hint = {
							enable = true,
							parameterHint = true,
						},
					},
				},
			},
			tsserver = {
				settings = {
					typescript = {
						format = {
							indentSize = vim.o.shiftwidth,
							convertTabsToSpaces = vim.o.expandtab,
							tabSize = vim.o.tabstop,
						},
						inlay_hints = {
							enable = true,
						},
					},
					javascript = {
						format = {
							indentSize = vim.o.shiftwidth,
							convertTabsToSpaces = vim.o.expandtab,
							tabSize = vim.o.tabstop,
						},
						inlay_hints = {
							enable = true,
						},
					},
					completions = {
						completeFunctionCalls = true,
					},
				},
			},
		},
		-- you can do any additional lsp server setup here
		-- return true if you don't want this server to be setup with lspconfig
		---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
		setup = {
			tsserver = function(_, opts)
				require("xyos.util").on_attach(function(client, buffer)
					if client.name == "tsserver" then
						-- stylua: ignore
						vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
						-- stylua: ignore
						vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
					end
				end)
				require("typescript").setup({ server = opts })
				return true
			end,
		},
	},
	---@param opts PluginLspOpts
	config = function(plugin, opts)
		-- setup autoformat
		require("xyos.util.lsp.format").autoformat = opts.autoformat
		-- setup formatting and keymaps
		require("xyos.util").on_attach(function(client, buffer)
			require("xyos.util.lsp.format").on_attach(client, buffer)
			require("xyos.util.lsp.keymaps").on_attach(client, buffer)
		end)

		local icons = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		}

		-- diagnostics
		for name, icon in pairs(icons) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end
		vim.diagnostic.config(opts.diagnostics)

		local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

		if opts.inlay_hints.enabled and inlay_hint then
			require("xyos.util").on_attach(function(client, buffer)
				if client.server_capabilities.inlayHintProvider then
					inlay_hint(buffer, true)
				end
			end)
		end

		local servers = opts.servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		local mlsp = require("mason-lspconfig")
		local available = mlsp.get_available_servers()

		local ensure_installed = {} ---@type string[]
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts
				-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
				if server_opts.mason == false or not vim.tbl_contains(available, server) then
					setup(server)
				else
					ensure_installed[#ensure_installed + 1] = server
				end
			end
		end

		require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup_handlers({ setup })
	end,
}
