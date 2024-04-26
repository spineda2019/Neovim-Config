-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({ "nvim-lua/plenary.nvim", tag = "v0.1.4" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- use ({
	-- 'rose-pine/neovim',
	-- as = 'rose-pine',
	-- config = function()
	-- vim.cmd('colorscheme rose-pine')
	-- end

	-- })

	use({ "nvim-treesitter/nvim-treesitter", tag = "v0.9.2", run = ":TSUpdate" })

	use({ "theprimeagen/harpoon", branch = "harpoon2", requires = { { "nvim-lua/plenary.nvim" } } })

	use({ "mbbill/undotree", tag = "rel_6.1" })

	use({ "williamboman/mason.nvim", tag = "v1.10.0" })
	use({ "williamboman/mason-lspconfig.nvim", tag = "v1.27.0" })
	use({ "neovim/nvim-lspconfig", tag = "v0.1.7" })

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			--- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})

	-- use("nvimtools/none-ls.nvim")

	use("mfussenegger/nvim-lint")

	use({ "tpope/vim-fugitive", tag = "v3.7" })

	use("petertriho/nvim-scrollbar")

	use({
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
	})

	use({
		"utilyre/barbecue.nvim",
		tag = "*",
		requires = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup()
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use("mfussenegger/nvim-dap")

	use({
		"folke/trouble.nvim",
		tag = "v2.10.0",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	})

	use({
		"folke/todo-comments.nvim",
		tag = "v1.1.0",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	if vim.fn.has("win32") ~= 1 then
		use({
			"nosduco/remote-sshfs.nvim",
			requires = { { "nvim-telescope/telescope.nvim" } }, -- optional if you declare plugin somewhere else
			tag = "v0.3.1",
		})
	end
end)
