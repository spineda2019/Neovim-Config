require("sebastian")
print("Welcome to Sebastian's NeoVim!")

vim.g.python_host_prog =
	"C:\\Users\\SEBASTIANP\\AppData\\Local\\Microsoft\\WindowsApps\\PythonSoftwareFoundation.Python.3.11_qbz5n2kfra8p0\\python.exe"

function ColorMyPencils()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Quick terminal

function OpenTerminalInNewTab()
	vim.cmd("lcd %:p:h")
	vim.cmd("tabnew | terminal")
	vim.cmd("startinsert")
end

function ExitSearchPattern()
	vim.cmd("noh")
end

vim.api.nvim_set_keymap("n", "<leader>t", ":lua OpenTerminalInNewTab()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":lua ExitSearchPattern()<CR>", { noremap = true, silent = true })

vim.cmd([[ 
autocmd BufEnter * highlight ColorColumn ctermbg=darkyellow guibg=darkyellow
autocmd FileType rust setlocal colorcolumn=100
autocmd FileType python setlocal colorcolumn=80
autocmd FileType c setlocal colorcolumn=80
autocmd FileType cpp setlocal colorcolumn=80
autocmd FileType javascript setlocal colorcolumn=80
autocmd FileType typescript setlocal colorcolumn=80
]])
