vim.g.mapleader = ' '
local keymap = vim.keymap

keymap.set('n', '<c-a>', 'ggVG')

keymap.set({ 'n', 'x' }, '<leader>p', '"0p')

keymap.set('n', '<leader>q', '<cmd>q<cr>')
keymap.set('n', '<leader>w', '<cmd>w<cr>')
keymap.set('n', '<leader>x', '<cmd>x<cr>')

keymap.set('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })

keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

vim.api.nvim_create_user_command('TimerlyToggle', function()
  require('timerly').toggle()
end, { desc = 'Toggle Timerly' })

vim.api.nvim_set_keymap(
  'n',
  '<leader>tt',
  ':TimerlyToggle<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_create_user_command('MintyHuefy', function()
  require('minty.huefy').open()
end, { desc = 'Open minty huefy' })

vim.api.nvim_set_keymap(
  'n',
  '<leader>kp',
  ':MintyHuefy<CR>',
  { desc = 'abre minty' }
)
