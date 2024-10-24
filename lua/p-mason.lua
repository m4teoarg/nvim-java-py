require('mason').setup({
  ui = {
    icons = {
      package_pending = ' ',
      package_installed = ' ',
      package_uninstalled = ' ',
    },
  },
})

require('mason-lspconfig').setup()

require('mason-tool-installer').setup({
  ensure_installed = {
    'lua-language-server',
    'stylua',
    'google-java-format',
    'jdtls',
  },
})
