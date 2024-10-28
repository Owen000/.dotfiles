return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local api = vim.api
      local keymap = vim.keymap
      local dashboard = require("dashboard")

      local conf = {}
      conf.header = {
        "                                                       ",
        "                                                       ",
        "                                                       ",
        " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
        " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
        " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
        " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
        " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
        "                                                       ",
        "                                                       ",
        "                                                       ",
        "                                                       ",
      }

      conf.center = {
        {
          icon = "󰈞  ",
          desc = "Find File                              ",
          action = function()
            require("telescope.builtin").find_files()
          end,
          key = "<Leader> p f",
        },
        {
          icon = "󰈢  ",
          desc = "Recently opened files                   ",
          action = function()
            require("telescope.builtin").oldfiles()
          end,
          key = "<Leader> p o",
        },
        {
          icon = "  ",
          desc = "Open Nvim config                        ",
          action = function()
            require("telescope.builtin").find_files({ cwd = vim.fn.expand("~/.config/nvim") })
          end,
          key = "<Leader> e c",
        },
        {
          icon = "  ",
          desc = "New file                                ",
          action = "enew",
          key = "e",
        },
        {
          icon = "󰗼  ",
          desc = "Quit Nvim                               ",
          action = "qa",
          key = "q",
        },
      }

      dashboard.setup({
        theme = "doom",
        shortcut_type = "number",
        config = conf,
      })

      api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
        callback = function()
          keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
          keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
        end,
      })

      vim.cmd("highlight DashboardHeader guifg=#98971a")
      vim.cmd("highlight DashboardFooter guifg=#83a598")
    end,
  },
}

