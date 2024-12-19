return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
        search = {
          enabled = false,
        },
      },
    },
    config = function(_, opts)
      local flash = require("flash")
      flash.setup(opts)

      local map = vim.api.nvim_set_keymap
      local map_opts = { noremap = true, silent = true }

      map("n", "s", '<cmd>lua require("flash").jump()<CR>', map_opts)
      map("x", "s", '<cmd>lua require("flash").jump()<CR>', map_opts)
      map("o", "s", '<cmd>lua require("flash").jump()<CR>', map_opts)

      map("n", "S", '<cmd>lua require("flash").treesitter()<CR>', map_opts)
      map("x", "S", '<cmd>lua require("flash").treesitter()<CR>', map_opts)
      map("o", "S", '<cmd>lua require("flash").treesitter()<CR>', map_opts)

      map("o", "r", '<cmd>lua require("flash").remote()<CR>', map_opts)
      map("o", "R", '<cmd>lua require("flash").treesitter_search()<CR>', map_opts)
      map("x", "R", '<cmd>lua require("flash").treesitter_search()<CR>', map_opts)

      map("c", "<c-s>", '<cmd>lua require("flash").toggle()<CR>', map_opts)
    end,
  },
}

