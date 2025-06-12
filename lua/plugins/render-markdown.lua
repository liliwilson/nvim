return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
    config = function()
        -- relink to the blue background in my theme
        local pmenu_sel = vim.api.nvim_get_hl(0, { name = "PmenuSel" })
        pmenu_sel.bold = true -- make it bold
        vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", pmenu_sel)

        -- change the link color
        vim.api.nvim_set_hl(0, "RenderMarkdownLink", { link = "ErrorMsg" })

        require("render-markdown").setup({})
    end
}
