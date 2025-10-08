return {
  name = "copy_range",
  dir = vim.fn.stdpath("config"),
  config = function()
    local mod = require('copy_range')
    
    -- Normal mode: make 'gy' an operator to select a motion, e.g. `gyap`
    vim.keymap.set('n', 'gy', function()
      vim.go.operatorfunc = "v:lua.require'copy_range'.opfunc"
      return 'g@'
    end, { expr = true, silent = true, desc = 'Copy file:line-range to clipboard (operator: gy)' })
    
    -- Visual mode: pressing 'gy' copies for the current selection
    vim.keymap.set('x', 'gy', function()
      mod.visual()
    end, { silent = true, desc = 'Copy file:line-range to clipboard (visual: gy)' })
    
    -- Linewise: gyy copies current line (like yy, but copies file:line)
    vim.keymap.set('n', 'gyy', function()
      mod.linewise()
    end, { silent = true, desc = 'Copy file:line to clipboard (gyy)' })
  end,
}
