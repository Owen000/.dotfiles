return {
  require("plugins.gruvbox"),
  require("plugins.catpuccin"),
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {
          { name = "Gruvbox", colorscheme = "gruvbox" },
          { name = "Default", colorscheme = "default" },
        },
        livePreview = true,
      })
    end,
  },
}

