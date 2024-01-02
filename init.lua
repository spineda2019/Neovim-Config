require("sebastian")
print("Welcome to Sebastian's NeoVim!")

function ColorMyPencils()
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
