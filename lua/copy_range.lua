local M = {}

local function get_relpath()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    return '[No Name]'
  end
  local rel = vim.fn.fnamemodify(bufname, ':.')
  if rel:sub(1, 1) ~= '/' and rel:sub(1, 2) ~= './' then
    rel = './' .. rel
  end
  return rel
end

local function copy_text(text)
  pcall(vim.fn.setreg, '+', text)
  pcall(vim.fn.setreg, '*', text)
  if vim.notify then
    pcall(vim.notify, 'Copied: ' .. text, vim.log.levels.INFO)
  end
end

local function yank_highlight_range_by_marks()
  local ok_view, view = pcall(vim.fn.winsaveview)
  pcall(vim.cmd, 'silent keepjumps normal! `[v`]"_y')
  if ok_view and view then pcall(vim.fn.winrestview, view) end
end

function M.copy_range(start_line, end_line)
  if not start_line or not end_line then return end
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local path = get_relpath()
  local out
  if start_line == end_line then
    out = string.format('%s:%d', path, start_line)
  else
    out = string.format('%s:%d-%d', path, start_line, end_line)
  end
  copy_text(out)
end

function M.opfunc(_type)
  -- Synchronous: marks '[' and ']' are available now
  local s = vim.api.nvim_buf_get_mark(0, '[')[1]
  local e = vim.api.nvim_buf_get_mark(0, ']')[1]
  if s == 0 or e == 0 then
    s = vim.fn.line('.')
    e = s
  end
  M.copy_range(s, e)
  yank_highlight_range_by_marks()
end

function M.visual()
  -- In visual-mode mapping, use 'v' (start of last visual) and '.' (cursor) for robust line nums
  local s = vim.fn.line('v')
  local e = vim.fn.line('.')
  M.copy_range(s, e)
  -- Trigger highlight without altering registers
  local ok_view, view = pcall(vim.fn.winsaveview)
  pcall(vim.cmd, 'silent keepjumps normal! gv"_y')
  if ok_view and view then pcall(vim.fn.winrestview, view) end
end

function M.linewise()
  local l = vim.fn.line('.')
  M.copy_range(l, l)
  -- Trigger TextYankPost highlight using black-hole register
  local ok_view, view = pcall(vim.fn.winsaveview)
  pcall(vim.cmd, 'silent keepjumps normal! "_yy')
  if ok_view and view then pcall(vim.fn.winrestview, view) end
end

return M
