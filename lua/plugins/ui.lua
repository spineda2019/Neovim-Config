return {

	--
	-- use ({
	-- 'rose-pine/neovim',
	-- as = 'rose-pine',
	-- config = function()
	-- vim.cmd('colorscheme rose-pine')
	-- end

	-- })

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.o.background = "dark"

			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				light_style = "day", -- The theme is used when the background is set to light
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

				--- You can override specific color groups to use other groups or a hex color
				--- function will be called with a ColorScheme table
				---@param colors ColorScheme
				on_colors = function(colors) end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with a Highlights and ColorScheme table
				---@param highlights Highlights
				---@param colors ColorScheme
				on_highlights = function(highlights, colors) end,
			})

			require("tokyonight").load()
		end,
	},

	{
		"petertriho/nvim-scrollbar",
		dependencies = { "folke/tokyonight.nvim" },
		config = function()
			local colors = require("tokyonight.colors").setup()
			require("scrollbar").setup({
				handle = {
					color = colors.bg_highlight,
				},
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warning },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
			})
		end,
	},

	{ "SmiteshP/nvim-navic" },

	{ "nvim-tree/nvim-web-devicons" },

	{
		"utilyre/barbecue.nvim",
		-- tag = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			-- triggers CursorHold event faster
			vim.opt.updatetime = 200
			require("barbecue").setup({
				create_autocmd = false, -- prevent barbecue from updating itself automatically
			})
			vim.api.nvim_create_autocmd({
				"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
				"BufWinEnter",
				"CursorHold",
				"InsertLeave",

				-- include this if you have set `show_modified` to `true`
				"BufModifiedSet",
			}, {
				group = vim.api.nvim_create_augroup("barbecue.updater", {}),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
		end,
	},
}
