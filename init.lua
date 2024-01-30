require("sebastian")
print("Welcome to Sebastian's NeoVim!")


vim.g.netrw_banner = 1

if vim.fn.has('win32') == 1 then
vim.o.shell = "pwsh"
vim.cmd("set shellcmdflag=-c")
vim.g.python_host_prog =
	"C:\\Users\\SEBASTIANP\\AppData\\Local\\Microsoft\\WindowsApps\\PythonSoftwareFoundation.Python.3.11_qbz5n2kfra8p0\\python.exe"
end



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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.cpp" },
	desc = "Auto-format c++ files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent !clang-format -style=Google "' .. fileName .. '"')
	end,
	group = autocmd_group,
})

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

vim.api.nvim_set_keymap("n", "<leader>t", ":lua OpenTerminalAbove()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":lua ExitSearchPattern()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":lua OpenFileTreeLeft()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":lua OpenFileTreeRight()<CR>", { noremap = true, silent = true })

vim.cmd([[ 
autocmd BufEnter * highlight ColorColumn ctermbg=darkyellow guibg=darkyellow
autocmd FileType rust setlocal colorcolumn=100
autocmd FileType python setlocal colorcolumn=80
autocmd FileType c setlocal colorcolumn=80
autocmd FileType cpp setlocal colorcolumn=80
autocmd FileType javascript setlocal colorcolumn=80
autocmd FileType typescript setlocal colorcolumn=80
]])
