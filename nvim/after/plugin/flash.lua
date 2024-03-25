local function setup_flash()
    local flash = require("flash")
    flash.setup({
      modes = {
        char = {
            enabled = false
        },
        search = {
          enabled = false,
        },
      },
    })

    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map('n', 's', '<cmd>lua require("flash").jump()<CR>', opts)
    map('x', 's', '<cmd>lua require("flash").jump()<CR>', opts)
    map('o', 's', '<cmd>lua require("flash").jump()<CR>', opts)

    map('n', 'S', '<cmd>lua require("flash").treesitter()<CR>', opts)
    map('x', 'S', '<cmd>lua require("flash").treesitter()<CR>', opts)
    map('o', 'S', '<cmd>lua require("flash").treesitter()<CR>', opts)

    map('o', 'r', '<cmd>lua require("flash").remote()<CR>', opts)
    map('o', 'R', '<cmd>lua require("flash").treesitter_search()<CR>', opts)
    map('x', 'R', '<cmd>lua require("flash").treesitter_search()<CR>', opts)

    map('c', '<c-s>', '<cmd>lua require("flash").toggle()<CR>', opts)
end

setup_flash()

