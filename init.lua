local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'neanias/everforest-nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',

  -- For vsnip users.
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  -- For luasnip users.
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',

  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  {
    'stevearc/conform.nvim',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
  },

  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  'nvim-treesitter/nvim-treesitter',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  'mg979/vim-visual-multi',
  'brenoprata10/nvim-highlight-colors',
  'kevinhwang91/promise-async',
  'luukvbaal/statuscol.nvim',
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
  },

  { 'mfussenegger/nvim-jdtls' },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      routes = {
        {
          filter = { event = 'notify', find = 'No information available' },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        config = function(_, opts)
          local dap = require('dap')
          local dapui = require('dapui')
          dap.set_log_level('INFO')
          dapui.setup(opts)
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close({})
          end
        end,
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mason.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            -- 'delve',
          },
        },
      },
      { 'jbyuki/one-small-step-for-vimkind', module = 'osv' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Función para obtener el nombre del LSP activo
      local lsp_status = function()
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return 'No LSP'
        end
        local client_names = {}
        for _, client in pairs(clients) do
          table.insert(client_names, client.name)
        end
        return table.concat(client_names, ', ')
      end
      require('lualine').setup({
        options = {
          theme = 'everforest',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'diff', 'diagnostics', lsp_status },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = {
            { 'fileformat', 'filetype' },
            {
              require('noice').api.statusline.mode.get,
              cond = require('noice').api.statusline.mode.has,
              color = { fg = '#ff9e64' },
            },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        extensions = {
          'fugitive',
          'quickfix',
          'fzf',
          'lazy',
          'mason',
          'nvim-dap-ui',
          'oil',
          'trouble',
        },
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map(
            'n',
            '<leader>hs',
            gs.stage_hunk,
            { desc = 'GitSigns state hunk' }
          )
          map(
            'n',
            '<leader>hr',
            gs.reset_hunk,
            { desc = 'GitSigns reset hunk' }
          )
          map('v', '<leader>hs', function()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = 'GitSigns stage_hunk' })
          map('v', '<leader>hr', function()
            gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = 'GitSigns reset_hunk' })
          map(
            'n',
            '<leader>hS',
            gs.stage_buffer,
            { desc = 'GitSigns stage_buffer' }
          )
          map(
            'n',
            '<leader>hu',
            gs.undo_stage_hunk,
            { desc = 'GitSigns undo_stage_hunk' }
          )
          map(
            'n',
            '<leader>hR',
            gs.reset_buffer,
            { desc = 'GitSigns reset_buffer' }
          )
          map(
            'n',
            '<leader>hp',
            gs.preview_hunk,
            { desc = 'GitSigns preview_hunk' }
          )
          map('n', '<leader>hb', function()
            gs.blame_line({ full = true })
          end, { desc = 'GitSigns blame line' })
          map(
            'n',
            '<leader>htb',
            gs.toggle_current_line_blame,
            { desc = 'GitSigns toggle blame' }
          )
          map('n', '<leader>hd', gs.diffthis, { desc = 'GitSigns diffthis' })
          map('n', '<leader>hD', function()
            gs.diffthis('~')
          end, { desc = 'GitSigns diffthis' })
          map(
            'n',
            '<leader>htd',
            gs.toggle_deleted,
            { desc = 'GitSigns toggle_deleted' }
          )

          -- Text object
          map(
            { 'o', 'x' },
            'ih',
            ':<C-U>Gitsigns select_hunk<CR>',
            { desc = 'GitSigns select hunk' }
          )
        end,
      })
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set(
        'n',
        '<leader>gs',
        vim.cmd.Git,
        { desc = 'Open Fugitive Panel' }
      )
    end,
  },
  'tpope/vim-repeat',
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {
      triggers = {
        { '<auto>', mode = 'nxso' },
      },
    },
  },
  { 'nvim-telescope/telescope-live-grep-args.nvim' },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },

  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup({
        keymaps = {
          accept_suggestion = '<Tab>',
          clear_suggestion = '<C-\\>',
          accept_word = '<C-j>',
        },
        ignore_filetypes = {
          cpp = true,
        },
        suggestion_color = '#ffffff',
        cterm = 244,
      })
    end,
  },

  { 'nvchad/volt', lazy = true },
  { 'nvchad/minty', lazy = true },
  { 'nvchad/timerly', cmd = 'TimerlyToggle' },
})

vim.cmd('colorscheme everforest')

-- require('colorschemes.apply_colors').apply_colors()

require('options')
require('mappings')
require('p-mason')
require('p-lsp')
require('lsp-lua')
require('p-conform')
require('p-tree')
require('p-telescope')
require('p-colorizer')
require('p-treesitter')
-- require('statusline')
require('p-cmp')
require('p-comment')
