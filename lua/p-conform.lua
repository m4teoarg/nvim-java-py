require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    python = { 'isort', 'black' },
    java = { 'google-java-format' },
    markdown = { { 'prettierd', 'prettier', stop_after_first = true } },
    -- You can customize some of the format options for the filetype (:help conform.format)
    -- rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  formatters = {
    -- Python
    black = {
      prepend_args = {
        '--fast',
        '--line-length',
        '80',
      },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 5000,
    lsp_format = 'fallback',
  },
})
