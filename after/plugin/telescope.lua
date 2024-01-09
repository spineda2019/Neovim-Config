local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
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
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})

require("telescope").load_extension("zf-native")
