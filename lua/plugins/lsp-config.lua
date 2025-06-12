return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("mason").setup({})
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "gopls", "html", "cssls" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            -- SETTING UP ALL OF THE INSTALLED LANGUAGES
            lspconfig.lua_ls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.gopls.setup({})
            lspconfig.html.setup({})
            lspconfig.cssls.setup({})

            -- shift + K now shows more info of the thing you are hovering
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            -- shift + E for opening errors
            vim.keymap.set('n', 'E', function()
                vim.diagnostic.open_float()
            end, {})

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>fc', vim.lsp.buf.format, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>e', vim.diagnostic.open_float, {})

            -- format on save
            vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })
            vim.diagnostic.config({
                float = {
                    border = "rounded", -- "single", "double", "shadow", or custom
                }
            })
        end
    }
}
