local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({

    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    --
    -- automatically check for plugin updates
    --   checker = {
    --       enabled = false,
    --       concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    --       notify = true,    -- get a notification when new updates are found
    --       frequency = 3600, -- check for updates every hour
    --       check_pinned = false, -- check for pinned packages that can't be updated
    --   },

})
