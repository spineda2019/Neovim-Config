return {
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },

	{ "nvim-lua/plenary.nvim", version = "v0.1.4" },

	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
	},

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.6",
		-- branch = "0.1.x",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
	},

	-- {
	-- 'rose-pine/neovim',
	-- as = 'rose-pine',
	-- config = function()
	-- vim.cmd('colorscheme rose-pine')
	-- end

	-- },

	{ "nvim-treesitter/nvim-treesitter", version = "v0.9.3", build = ":TSUpdate", event = "BufReadPost" },

	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		event = "BufReadPost",
	},

	{ "mbbill/undotree", version = "rel_6.1", event = "BufReadPost" },

	{ "williamboman/mason.nvim", version = "v1.10.0", cmd = "Mason" },
	{ "williamboman/mason-lspconfig.nvim", version = "v1.27.0", event = "BufReadPost" },
	{ "neovim/nvim-lspconfig", version = "v0.1.7", event = "BufReadPost" },

	{ "hrsh7th/nvim-cmp", event = "BufReadPost" },
	{ "hrsh7th/cmp-nvim-lsp", event = "BufReadPost" },

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
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
		event = "BufReadPost",
	},

	-- "nvimtools/none-ls.nvim",

	{ "mfussenegger/nvim-lint", event = "BufReadPost" },

	{ "tpope/vim-fugitive", version = "v3.7" },

	"petertriho/nvim-scrollbar",

	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
	},

	{
		"utilyre/barbecue.nvim",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},

	"mfussenegger/nvim-dap",

	{
		"folke/trouble.nvim",
		version = "v2.10.0",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "BufReadPost",
	},

	{
		"folke/todo-comments.nvim",
		version = "v1.1.0",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
		event = "BufReadPost",
	},
}
