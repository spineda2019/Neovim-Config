-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.5",
		branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- use ({
	-- 'rose-pine/neovim',
	-- as = 'rose-pine',
	-- config = function()
	-- vim.cmd('colorscheme rose-pine')
	-- end

	-- })

	use("Mofiqul/vscode.nvim")

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("nvim-lua/plenary.nvim")

	use({ "theprimeagen/harpoon", branch = "harpoon2", requires = { { "nvim-lua/plenary.nvim" } } })

	use("mbbill/undotree")

	use("natecraddock/telescope-zf-native.nvim")

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            --- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    -- use("nvimtools/none-ls.nvim")

    use("mfussenegger/nvim-lint")

    use("tpope/vim-fugitive")

    use("petertriho/nvim-scrollbar")

    use({
        "folke/tokyonight.nvim",
		lazy = false,
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
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

end)
