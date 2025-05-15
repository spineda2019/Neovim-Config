return {
	{
		"williamboman/mason.nvim",
		tag = "v1.10.0",
		config = function()
			require("mason").setup({
				pip = {
					upgrade_pip = true,
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		tag = "v1.27.0",
		config = function() end,
	},
	{
		"neovim/nvim-lspconfig",
		tag = "v0.1.7",
		config = function() end,
	},
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "L3MON4D3/LuaSnip" },

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- LSP Support
			"neovim/nvim-lspconfig",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
				lsp_zero.buffer_autoformat()
			end)

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-h>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-n>"] = cmp.mapping.scroll_docs(-4),
					["<C-p>"] = cmp.mapping.scroll_docs(4),
				}),
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"clangd",
					"cssls",
					"html",
					"tsserver",
					"pyright",
					"taplo",
					"omnisharp",
					"zls",
				},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})

			require("lspconfig").pyright.setup({})
			require("lspconfig").pyright.setup({})
			require("lspconfig").omnisharp.setup({})
			require("lspconfig").clangd.setup({})
			require("lspconfig").rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							allFeatures = true,
							overrideCommand = {
								"cargo",
								"clippy",
								"--workspace",
								"--message-format=json",
								"--all-targets",
								"--all-features",
							},
						},
					},
				},
			})

			-- Show line diagnostics automatically in hover window
			vim.o.updatetime = 250
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
		end,
	},

	-- use("nvimtools/none-ls.nvim")

	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				markdown = { "vale" },
				python = { "flake8" },
				c = { "cpplint" },
				cpp = { "cpplint" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
