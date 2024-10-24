local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set(
  'n',
  '<leader>f',
  builtin.find_files,
  { desc = 'Telescope find files' }
)
keymap.set(
  'n',
  '<leader>g',
  builtin.live_grep,
  { desc = 'Telescope live grep' }
)

local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['esc'] = actions.close,
      },
    },
    file_ignore_patterns = {
      'codegen.ts',
      '.git',
      'lazy-lock.json',
      '*-lock.yaml',
      'node_modules',
      '%.lock',
    },
    dynamic_preview_title = true,
    path_display = { 'smart' },
    borders = false,
    preview = {
      winblend = 20,
      width = 0.55,
      height = 0.55,
    },
  },

  pickers = {
    find_files = {
      hidden = true,
    },
  },
  layout_config = {
    horizontal = {
      preview_cutoff = 100,
      preview_width = 0.5,
      prompt_position = 'top',
    },
  },
})
