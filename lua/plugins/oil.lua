-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        local oil = require("oil")
        local detail = false

        oil.setup({
            -- toggle file details with gd (size)
            keymaps = {
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,

                },
            },
        })



        vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<leader>v", "<CMD>vsplit<CR><CMD>Oil<CR>", { desc = "Open a vertical split in oil" })
    end
}
