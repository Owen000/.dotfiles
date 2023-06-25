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
    lazy = false,
    cmd = {'Trouble'},
    config = function()
      require("trouble").setup {
        icons = true,
      }
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        highlight = { enable = true }
      }
    end
  },

  {'nvim-treesitter/playground', lazy = false},
  {'theprimeagen/harpoon', cmd = {'Harpoon'}},
  {'theprimeagen/refactoring.nvim', cmd = {'Refactoring'}},
  {'mbbill/undotree', cmd = {'UndotreeShow'}},
  {'tpope/vim-fugitive', cmd = {'Gstatus', 'Gcommit', 'Gpush', 'Gpull'}},
  {'ellisonleao/gruvbox.nvim', cmd = {'Colorscheme gruvbox'}},
  {'nvim-treesitter/nvim-treesitter-context', lazy = false},

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

  {'folke/zen-mode.nvim', cmd = {'ZenMode'}},
  {'eandrju/cellular-automaton.nvim'},
}

require("lazy").setup(plugins, opts)
