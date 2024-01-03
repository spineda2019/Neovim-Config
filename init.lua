require("sebastian")
print("Welcome to Sebastian's NeoVim!")

vim.g.python_host_prog = 'C:\\Users\\SEBASTIANP\\AppData\\Local\\Microsoft\\WindowsApps\\PythonSoftwareFoundation.Python.3.11_qbz5n2kfra8p0\\python.exe' 

function ColorMyPencils()
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Quick terminal

function OpenTerminalInNewTab()
    vim.cmd('lcd %:p:h')
    vim.cmd('tabnew | terminal')
    vim.cmd('startinsert')
end

vim.api.nvim_set_keymap('n', '<leader>t', ':lua OpenTerminalInNewTab()<CR>', {noremap = true, silent = true})

