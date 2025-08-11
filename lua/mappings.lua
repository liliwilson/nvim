-- make space my leader key
vim.g.mapleader = " "

-- Rebind "*p to <leader>pv (paste from system clipboard)
vim.api.nvim_set_keymap('n', '<leader>pv', '"*p', { noremap = true, silent = true })
-- Rebind "*y to <leader>cv (copy to system clipboard)
vim.api.nvim_set_keymap('n', '<leader>cv', '"*y', { noremap = true, silent = true })
-- Invoke alpha with <leader>a
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>Alpha<cr>', { noremap = true, silent = true })


local map = vim.keymap.set

-- escape key alternatives
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- easier to move around splits
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

--  disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- disable highlights
map("n", "<leader>n", "<cmd>noh<CR>")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- mappings for buffers
map("n", "<Tab>", "<cmd>bnext<CR>")
map("n", "<S-Tab>", "<cmd>bprev<CR>")

-- mappings for split
vim.o.splitright = true

-- open a vsplit and move cursor
map("n", "<leader>v", "<cmd>vs<CR><C-w><C-l>")
-- open a vsplit and open alpha
map("n", "<leader>h", "<cmd>vs<CR><C-w><C-l><cmd>Alpha<CR><cmd>:BD #<CR>")

-- Enter resize mode with <leader>w (defined in window-resize plugin)
map("n", "<leader>w", function()
    if _G.enter_resize_mode then
        _G.enter_resize_mode()
    end
end)

-- Toggle git blame with <leader>gb
map("n", "<leader>gb", "<cmd>GitBlameToggle<CR>")
