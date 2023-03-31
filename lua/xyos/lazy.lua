local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	require("xyos.plugins.telescope"),
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
	-- StatusLine
	"nvim-lualine/lualine.nvim",
	-- colorschemes
	require("xyos.plugins.catppuccin"),
	"folke/tokyonight.nvim",
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},

	"theprimeagen/harpoon",
	"mbbill/undotree",

	require("xyos.plugins.lsp.lsp"),
	require("xyos.plugins.lsp.mason"),
	require("xyos.plugins.lsp.null_ls"),
	require("xyos.plugins.cmp.cmp"),
	require("xyos.plugins.cmp.lua_snip"),
	require("xyos.plugins.copilot"),
	require("xyos.plugins.gpt"),
	require("xyos.plugins.neogit"),

	-- Utilities
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
	"akinsho/toggleterm.nvim", -- terminal

	-- UI
	"p00f/nvim-ts-rainbow",
	"lukas-reineke/indent-blankline.nvim",

	-- Highlight

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	-- "nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-refactor",
	"nvim-treesitter/nvim-tree-docs",
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- Git
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- statuscol
	"luukvbaal/statuscol.nvim",
	-- DAP
	-- 'mfussenegger/nvim-dap',
	-- 'rcarriga/nvim-dap-ui',
	-- 'theHamsta/nvim-dap-virtual-text',
	-- 'nvim-telescope/telescope-dap.nvim',
	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	-- neotree
	{
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
	},
	-- neogit
	{
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true,
				},
			})
		end,
	},
	-- diffview
	{
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("diffview").setup()
		end,
	},
	-- bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = {
						Error = " ",
						Warn = " ",
						Hint = " ",
						Info = " ",
					}
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},
})
