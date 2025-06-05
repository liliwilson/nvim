return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        -- configure syntax highlighting
        local config = require("nvim-treesitter.configs")
        config.setup({
            -- Only pre-install the most commonly used ones
            ensure_installed = { "lua", "rust", "python" },
            -- Other languages will be installed on-demand
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
