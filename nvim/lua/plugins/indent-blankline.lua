return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      exclude = {
        filetypes = { "dashboard" },
        buftypes = { "terminal" },
      },
      indent = {
        tab_char = "▎",
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)

      vim.opt.list = true
      vim.opt.listchars = {
        trail = '·',
        tab = '  '
      }
    end,
  },
}

