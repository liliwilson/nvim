return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        lazy = true,
        cmd = "Telescope",
        keys = {
            { "<C-p>" },
            { "<leader>fg" },
            { "<leader>fs" },
            { "<leader>fr" },
            { "<leader>fb" },
            { "<leader>fe" },
            { "<leader>fa" },
            { "<leader>la" },
            { "<leader>fj" },
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- fzf settings!
            local builtin = require('telescope.builtin')
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local previewers = require('telescope.previewers')
            local from_entry = require('telescope.from_entry')
            local conf = require('telescope.config').values

            -- find_files wrapper: supports "filename:line" to preview/goto line
            local function find_files_with_line()
                local line_num = nil

                local previewer = previewers.new_buffer_previewer({
                    title = "File Preview",
                    get_buffer_by_name = function(self, entry)
                        return from_entry.path(entry, false)
                    end,
                    define_preview = function(self, entry, status)
                        local p = from_entry.path(entry, true)
                        if p == nil or p == "" then return end
                        conf.buffer_previewer_maker(p, self.state.bufnr, {
                            bufname = self.state.bufname,
                            winid = self.state.winid,
                            callback = function(bufnr)
                                if line_num and line_num > 0 then
                                    vim.schedule(function()
                                        pcall(vim.api.nvim_win_set_cursor, self.state.winid, { line_num, 0 })
                                    end)
                                end
                            end,
                        })
                    end,
                })

                builtin.find_files({
                    previewer = previewer,
                    on_input_filter_cb = function(prompt)
                        local file, lnum = prompt:match("(.+):(%d+)$")
                        if file and lnum then
                            line_num = tonumber(lnum)
                            return { prompt = file }
                        end
                        line_num = nil
                        return { prompt = prompt }
                    end,
                    attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(function()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            if selection then
                                local p = selection.path or selection[1]
                                vim.cmd("edit " .. vim.fn.fnameescape(p))
                                if line_num then
                                    local target = math.min(line_num, vim.api.nvim_buf_line_count(0))
                                    vim.api.nvim_win_set_cursor(0, { target, 0 })
                                    vim.cmd("normal! zz")
                                end
                            end
                        end)
                        return true
                    end,
                })
            end

            -- set ctrl+P to find files (with :line support)
            vim.keymap.set('n', '<C-p>', find_files_with_line, {})
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
            -- workspace symbols (LSP)
            vim.keymap.set('n', "<leader>fj", builtin.lsp_workspace_symbols, {})
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
                highlight_on_jump = false,
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with arrows
                    vim.keymap.set("n", "<", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", ">", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
            })
            -- workspace symbols (LSP)
            vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
        end
    }
}
