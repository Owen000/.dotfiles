return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      yaml = { "actionlint" },
      bash = { "shellcheck" },
    }

    vim.api.nvim_set_keymap("n", "<leader>l", ":lua require('lint').try_lint()<CR>", { noremap = true, silent = true })
  end,
}

