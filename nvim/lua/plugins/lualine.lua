return {
  {
    "nvim-lualine/lualine.nvim",  -- Ensure you're using the correct plugin path
    event = "VeryLazy",
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'gruvbox',  -- Set your preferred theme
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,  -- Enable global status line
          always_divide_middle = true,
          disabled_filetypes = {  -- Exclude specific file types
            statusline = { 'NvimTree' },  -- Disable status line in NvimTree
            winbar = {},
          },
          ignore_focus = { 'NvimTree' },  -- Ignore focus for NvimTree to keep it inactive
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end,
  },
}

