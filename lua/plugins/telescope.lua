return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- fzf settings!
            local builtin = require('telescope.builtin')

            -- set ctrl+P to find files
            vim.keymap.set('n', '<C-p>', builtin.find_files, {})
            -- set leader + fg to do live grep, right now this is space+fg
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            -- set leader + fs to grep the currently selected thing
            vim.keymap.set('n', '<leader>fs', ":Telescope grep_string<CR>", { noremap = true, silent = true })
            -- oldfiles
            vim.keymap.set('n', "<Leader>fr", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
            -- buffers
            vim.keymap.set('n', "<Leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })
            -- errors, current file
            vim.keymap.set('n', "<Leader>fe", ":Telescope diagnostics bufnr=0<CR>", { noremap = true, silent = true })
            -- errors, all files
            vim.keymap.set('n', "<Leader>fa", ":Telescope diagnostics<CR>", { noremap = true, silent = true })
            -- symbols
            vim.keymap.set('n', "<leader>la", ":Telescope aerial<CR>", { noremap = true, silent = true })
        end
    },

    -- this package allows us to use telescope's ui for select
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    },

    {
        'stevearc/aerial.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
            })
            -- toggle the aerial sidebar
            vim.keymap.set("n", "<leader>ls", "<cmd>AerialToggle!<CR>")
        end
    }
}
