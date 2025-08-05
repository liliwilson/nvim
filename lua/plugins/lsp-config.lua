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
                ensure_installed = { "lua_ls", "clangd", "gopls", "html", "cssls", "rust_analyzer" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                float = {
                    border = "rounded",
                }
            })

            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set('n', 'K', function()
                    vim.lsp.buf.hover({ border = 'rounded' })
                end, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gh', function()
                    vim.cmd('vsplit')
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>fc', vim.lsp.buf.format, opts)
            end

            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local servers = { "lua_ls", "clangd", "gopls", "html", "cssls" }
            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end

            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        linkedProjects = {},
                        workspace = {
                            symbol = {
                                search = {
                                    scope = "workspace",
                                },
                            },
                        },
                        procMacro = {
                            server = "rust-analyzer",
                        },
                    },
                },
                root_dir = function(fname)
                    local cargo_toml = vim.fs.find('Cargo.toml', { path = fname, upward = true })[1]
                    if cargo_toml then
                        local cargo_dir = vim.fn.fnamemodify(cargo_toml, ':h')
                        local cargo_contents = vim.fn.readfile(cargo_toml)
                        for _, line in ipairs(cargo_contents) do
                            if line:match('^%s*%[workspace%]') then
                                return cargo_dir
                            end
                        end
                        local workspace_root = vim.fs.find('Cargo.toml', {
                            path = vim.fn.fnamemodify(cargo_dir, ':h'),
                            upward = true,
                            stop = vim.fn.expand('~')
                        })
                        for _, potential_root in ipairs(workspace_root) do
                            local potential_contents = vim.fn.readfile(potential_root)
                            for _, line in ipairs(potential_contents) do
                                if line:match('^%s*%[workspace%]') then
                                    return vim.fn.fnamemodify(potential_root, ':h')
                                end
                            end
                        end
                        return cargo_dir
                    end
                    return nil
                end,
            })

            vim.keymap.set('n', 'E', vim.diagnostic.open_float, {})
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})

            -- format on save
            vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")
        end
    }
}
