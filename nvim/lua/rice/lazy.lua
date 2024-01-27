local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {'folke/lazy.nvim', lazy = false, priority = 1000},

  {'nvim-telescope/telescope.nvim', cmd = {"Telescope"}, dependencies = {'nvim-lua/plenary.nvim'}},


  {
    'folke/trouble.nvim',
    lazy = true,
    cmd = {'Trouble'},
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
      }
    end
  },

  {'nvim-lualine/lualine.nvim'},
  {'mhartington/formatter.nvim'},
  {'nvim-treesitter/playground', lazy = false},
  {'theprimeagen/refactoring.nvim', lazy = true, cmd = {'Refactoring'}},
  {'mbbill/undotree', cmd = {'UndotreeShow'}},
  {'tpope/vim-fugitive', event = { "BufReadPost", "BufNewFile" }, cmd = {'Gstatus', 'Gcommit', 'Gpush', 'Gpull'}},
  {'ellisonleao/gruvbox.nvim', priority = 1000, cmd = {'Colorscheme gruvbox'}},
  {'nvim-treesitter/nvim-treesitter-context', lazy = false},
  {'nvim-tree/nvim-web-devicons'},
  {'nvim-tree/nvim-tree.lua'},
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async', event = { "BufReadPost", "BufNewFile" }},
  {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  {'nvim-telescope/telescope-ui-select.nvim'},
  {'barreiroleo/ltex_extra.nvim'},
  {'luukvbaal/statuscol.nvim', event = { "BufReadPost", "BufNewFile"}},
  {
  'NvChad/nvim-colorizer.lua', lazy = false,
  config = function()
    require('colorizer').setup()
  end
  },

  {
      'tris203/hawtkeys.nvim', lazy = true, cmd = {'Hawtkeys', 'HawtkeysAll', 'HawtkeysDupes'},
      config = {}
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },

  {
  "mickael-menu/zk-nvim",
  config = function()
    require("zk").setup({
      -- See Setup section below
    })
  end
  },

  {
  'barreiroleo/ltex_extra.nvim',
    ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("ltex_extra").setup {
          load_langs = { "en-US" }, -- Modify this to your desired languages.
          server_opts = {
              settings = {
                  ltex = {
                      enabled = true
                  }
              }
          },
      }
    end
  },

  {
    'folke/which-key.nvim',
    lazy = false,
    cmd = {'WhichKey'},
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    branch = 'v1.x',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    }
  },

    {
    'Bekaboo/dropbar.nvim', lazy = false,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    }
  },

  {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
 },

  {'folke/zen-mode.nvim', cmd = {'ZenMode'}},
  {'eandrju/cellular-automaton.nvim', lazy = true},
}

require("lazy").setup(plugins, require("rice.lazy_settings"), { lazy = true })
