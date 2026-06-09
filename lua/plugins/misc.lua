-- Initial port from packer after files

return {
    {
        "nvim-lua/plenary.nvim",
        tag = "v0.1.4",
        lazy = true,
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        -- branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<C-g>", "<cmd>Telescope git_files<CR>", desc = "Git files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
        },
        opts = {
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
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        commit = "4916d6592ede8c07973490d9322f187e07dfefac",
        build = ":TSUpdate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            if vim.fn.has("win32") == 1 then
                require("nvim-treesitter.install").compilers = { "zig" }
            else
                require("nvim-treesitter.install").compilers = { "gcc" }
            end
            require("nvim-treesitter").setup({

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
                    "markdown_inline",
                    "zig",
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
        lazy = true,
        keys = "<leader>e",
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
        cmd = "UndotreeToggle",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undotree" },
        },
    },

    {
        "tpope/vim-fugitive",
        tag = "v3.7",
        cmd = {
            "Git",
            "G",
            "Gdiffsplit",
            "Gread",
            "Gwrite",
            "Ggrep",
            "GMove",
            "GDelete",
        },
        keys = {
            { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        lazy = true,
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

    {
        "mfussenegger/nvim-dap",
        cmd = {
            "DapContinue",
            "DapToggleBreakpoint",
            "DapStepOver",
            "DapStepInto",
            "DapStepOut",
            "DapTerminate",
        },
    },

    {
        "folke/trouble.nvim",
        tag = "v2.10.0",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>p", "<cmd>Trouble<CR>", desc = "Trouble" },
            { "<leader>r", "<cmd>TroubleRefresh<CR>", desc = "Trouble refresh" },
        },
    },

    {
        "folke/todo-comments.nvim",
        lazy = true,
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

    {
      "sphamba/smear-cursor.nvim",

      event = "VeryLazy",
    
      opts = {
        -- Smear cursor when switching buffers or windows.
        smear_between_buffers = true,
    
        -- Smear cursor when moving within line or to neighbor lines.
        -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
        smear_between_neighbor_lines = true,
    
        -- Draw the smear in buffer space instead of screen space when scrolling
        scroll_buffer_space = true,
    
        -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
        -- Smears and particles will look a lot less blocky.
        legacy_computing_symbols_support = false,
    
        -- Smear cursor in insert mode.
        -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
        smear_insert_mode = true,
      },
    },
}
