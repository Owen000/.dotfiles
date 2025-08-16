return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        separator_style = "slant",
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "dashboard",
            text = "Dashboard",
            highlight = "Directory",
            text_align = "left",
            separator = false,
          },
        },
      },
    })

    for i = 1, 9 do
      vim.api.nvim_set_keymap(
        "n",
        "<leader>" .. i,
        '<cmd>lua require("bufferline").go_to(' .. i .. ", true)<CR>",
        { noremap = true, silent = true }
      )
    end

    vim.api.nvim_set_keymap(
      "n",
      "<leader>$",
      '<cmd>lua require("bufferline").go_to(-1, true)<CR>',
      { noremap = true, silent = true }
    )

    vim.api.nvim_set_keymap("n", "<Leader>bd", ":bdelete<CR>", { noremap = true, silent = true })

    local wk = require("which-key")
    local ignore_mappings = {}

    for i = 1, 9 do
      table.insert(ignore_mappings, { "", desc = "<leader>" .. i, hidden = true })
    end
    table.insert(ignore_mappings, { "", desc = "<leader>$", hidden = true })

    wk.add(ignore_mappings)
  end,
}

