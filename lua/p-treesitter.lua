require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    'lua',
    'vim',
    'vimdoc',
    'query',
    'markdown',
    'markdown_inline',
    'python',
    'html',
    'tsx',
    'css',
    'typescript',
    'javascript',
    'json',
    'graphql',
    'regex',
    'rust',
    'prisma',
    'java',
  },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },

  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<enter>',
      node_incremental = '<enter>',
      scope_incremental = false,
      node_decremental = '<bs>',
    },
  },
})
