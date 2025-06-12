require("mappings")

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nu rnu")

vim.o.termguicolors = true
vim.opt.cursorline = true

-- folding settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""

-- snippets
vim.g.snipmate_snippets_path = "~/.config/nvim/snippets/"


require("config.lazy")
