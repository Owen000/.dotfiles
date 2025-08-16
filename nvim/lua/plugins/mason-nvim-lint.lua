return {
  "rshkarin/mason-nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("mason-nvim-lint").setup()
  end,
}

