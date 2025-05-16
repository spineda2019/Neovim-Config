-- Initial port from packer after files

return {
	{
		"nvim-lua/plenary.nvim",
		tag = "v0.1.4",
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<C-g>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"%.jpeg",
						"%.jpg",
						"%.png",
						"%.pdf",
						"%.doc",
						"%.docx",
						"%.xlsx",
						"%.vi",
						"%.lvproj",
						"%.db",
						"%.gbl",
						"%.gbs",
						"%.gbo",
						"%.gbp",
						"%.exe",
						"%.dll",
						"%.so",
					},
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.3",
		build = ":TSUpdate",
        lazy = "true"
        event = "BufReadPost",
		config = function()
			if vim.fn.has("win32") == 1 then
				require("nvim-treesitter.install").compilers = { "zig" }
			else
				require("nvim-treesitter.install").compilers = { "gcc" }
			end
			require("nvim-treesitter.configs").setup({

				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"python",
					"c",
					"cpp",
					"rust",
					"javascript",
					"typescript",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():append()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-S-N>", function()
				harpoon:list():next()
			end)
		end,
	},

	{
		"mbbill/undotree",
		tag = "rel_6.1",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	{
		"tpope/vim-fugitive",
		tag = "v3.7",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
        lazy = "true",
        event = "BufReadPost",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "tokyonight",
					transparent = false, -- Enable this to disable setting the background color
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},

	{ "mfussenegger/nvim-dap" },

	{
		"folke/trouble.nvim",
		tag = "v2.10.0",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>p", ":Trouble <CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>r", ":TroubleRefresh <CR>", { noremap = true, silent = true })
		end,
	},

	{
		"folke/todo-comments.nvim",
        lazy = "true",
        event = "BufReadPost",
		tag = "v1.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
}
