require("sebastian")
print("Welcome to Sebastian's NeoVim!")

vim.g.netrw_banner = 1

function ColorMyPencils()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Quick terminal
vim.cmd("highlight MyTerminal guibg=#772953 ctermbg=DarkMagenta")

function OpenTerminalAbove()
	vim.cmd("lcd %:p:h")
	vim.cmd("belowright split | terminal")
	vim.cmd("setlocal winhighlight=Normal:MyTerminal")
	vim.cmd("startinsert")
end

-- Basic FileTree

function OpenFileTreeLeft()
	vim.g.netrw_banner = 0
	vim.cmd("lcd %:p:h")
	vim.cmd("vsplit | Ex")
	vim.cmd("vertical resize 30")
	vim.g.netrw_banner = 1
end

function OpenFileTreeRight()
	vim.g.netrw_banner = 0
	vim.cmd("lcd %:p:h")
	vim.cmd("rightbelow vsplit | Ex")
	vim.cmd("vertical resize 30")
	vim.g.netrw_banner = 1
end

function ExitSearchPattern()
	vim.cmd("noh")
end

-- Save on write
local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.py" },
	desc = "Auto-format python files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent !autopep8 --in-place "' .. fileName .. '"')
	end,
	group = autocmd_group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.rs" },
	desc = "Auto-format rust files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent !rustfmt "' .. fileName .. '"')
	end,
	group = autocmd_group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.lua" },
	desc = "Auto-format lua files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent !stylua "' .. fileName .. '"')
	end,
	group = autocmd_group,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	pattern = { "*.cpp" },
-- 	desc = "Auto-format c++ files after saving",
-- 	callback = function()
-- 		local fileName = vim.api.nvim_buf_get_name(0)
-- 		vim.cmd(':silent !clang-format -style=Google "' .. fileName .. '"')
-- 	end,
-- 	group = autocmd_group,
-- })

if vim.fn.has("win32") == 1 then
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = { "*.js" },
		desc = "Auto-format javascript files after saving",
		callback = function()
			local fileName = vim.api.nvim_buf_get_name(0)
			vim.cmd(':silent !prettier.cmd -w "' .. fileName .. '"')
		end,
		group = autocmd_group,
	})

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = { "*.ts" },
		desc = "Auto-format typescript files after saving",
		callback = function()
			local fileName = vim.api.nvim_buf_get_name(0)
			vim.cmd(':silent !prettier.cmd -w "' .. fileName .. '"')
		end,
		group = autocmd_group,
	})
else
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = { "*.js" },
		desc = "Auto-format javascript files after saving",
		callback = function()
			local fileName = vim.api.nvim_buf_get_name(0)
			vim.cmd(':silent !prettier -w "' .. fileName .. '"')
		end,
		group = autocmd_group,
	})

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = { "*.ts" },
		desc = "Auto-format typescript files after saving",
		callback = function()
			local fileName = vim.api.nvim_buf_get_name(0)
			vim.cmd(':silent !prettier -w "' .. fileName .. '"')
		end,
		group = autocmd_group,
	})
end

vim.api.nvim_set_keymap("n", "<leader>t", ":lua OpenTerminalAbove()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":lua ExitSearchPattern()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":lua OpenFileTreeLeft()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":lua OpenFileTreeRight()<CR>", { noremap = true, silent = true })

vim.cmd([[ 
autocmd BufEnter * highlight ColorColumn ctermbg=darkyellow guibg=darkyellow
autocmd FileType rust setlocal colorcolumn=101
autocmd FileType python setlocal colorcolumn=80
autocmd FileType c setlocal colorcolumn=81
autocmd FileType cpp setlocal colorcolumn=81
autocmd FileType javascript setlocal colorcolumn=81
autocmd FileType typescript setlocal colorcolumn=81
]])

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
