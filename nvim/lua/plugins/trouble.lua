return {
  "folke/trouble.nvim",
    opts = {},
  cmd = "Trouble",
  vim.keymap.set("n", "<leader>vq", "<cmd>Trouble diagnostics<cr>", { silent = true, noremap = true }),
}

