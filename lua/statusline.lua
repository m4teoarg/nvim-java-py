-- vim.o.statusline = '%#StatusLineNormal# %f %y %m %= %l:%c %p%%'
require('nvim-web-devicons').setup({})

-- groups
vim.cmd('highlight StatusLine guibg=#353b45')
vim.cmd('highlight StatusLineMode guifg=#1e222a guibg=#81A1C1')
vim.cmd('highlight StatusLineSep guifg=#565c64 guibg=#565c64')
vim.cmd('highlight StatusLineSep_p guifg=#353b45 guibg=#353b45')
vim.cmd('highlight StatusLineFiletype guifg=#abb2bb guibg=#353b45')
vim.cmd('highlight StatusLinePath guifg=#abb2bf guibg=#2d3139')
vim.cmd('highlight StatusLinePosition guifg=#abb2bf guibg=#353b45')
vim.cmd('highlight StatusLineCenter guibg=#262a31')

local mode_icons = {
  n = ' ',
  i = ' ',
  c = ' ',
  v = ' ',
  V = ' ',
  [' '] = ' ', -- Visual Block
  R = ' ', -- Replace
  s = ' ', -- Select
}

local modes = {
  n = 'Normal', -- Normal
  i = 'Insert', -- Insert
  c = 'Command', -- Command
  v = 'VISUAL', -- Visual
  V = 'VISUAL LINE', -- Visual Line
  [' '] = 'VISUAL BLOCK', -- Visual Block
  R = 'REPLACE', -- Replace
  s = 'SELECT', -- Select
}

_G.get_mode = function()
  local mode = vim.fn.mode()
  local mode_icon = mode_icons[mode] or ''
  local mode_text = modes[mode] or mode
  local padding = ' '
  return padding .. ' ' .. mode_icon .. mode_text
end

-- Obtener el ícono del archivo
local function get_file_icon_and_name()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    return '󰈚  Empty'
  else
    local name = vim.fn.fnamemodify(path, ':t')
    local icon = require('nvim-web-devicons').get_icon(
      name,
      vim.fn.expand('%:e'),
      { default = true }
    )
    return icon .. ' ' .. name
  end

  -- local name = vim.fn.fnamemodify(path, ':t')
  -- local icon = require('nvim-web-devicons').get_icon(
  -- name,
  -- vim.fn.expand('%:e'),
  -- { default = true }
  -- )
  -- return icon .. ' ' .. name
end

vim.o.statusline = '%#StatusLineMode#%{v:lua.get_mode()} '
vim.o.statusline = vim.o.statusline .. '%#StatusLineSep#█'
vim.o.statusline = vim.o.statusline .. '%#StatusLine# '
vim.o.statusline = vim.o.statusline
  .. '%#StatusLineFiletype#'
  .. get_file_icon_and_name()
  .. ' '
vim.o.statusline = vim.o.statusline .. '%#StatusLineCenter#%='
vim.o.statusline = vim.o.statusline .. '%=  '
vim.o.statusline = vim.o.statusline .. '%#StatusLineSep_p#█'
vim.o.statusline = vim.o.statusline .. '%#StatusLinePosition#%l:%c '
vim.o.statusline = vim.o.statusline .. '%#StatusLinePosition#%p%% '
