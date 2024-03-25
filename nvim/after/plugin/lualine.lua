require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic', 'coc' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = { error = ' ', warn = ' ', hint = '󰌵 ', info = '󰋼 '}
      }
    },
    lualine_c = {'filename'},
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#e2d3ac" },
      }
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

