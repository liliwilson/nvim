return {
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
        require("luasnip").config.set_config(opts)
        require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
    end,
}
