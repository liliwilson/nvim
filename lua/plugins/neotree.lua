return  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", 
        "MunifTanjim/nui.nvim",
    },
    config = function()
        -- set up neotree for file system, ctrl+N for opening
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
    end
}
