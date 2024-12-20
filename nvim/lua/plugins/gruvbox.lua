return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      terminal_colors = false,
      overrides = {
        ["Delimiter"] = { link = "GruvboxOrange" },
        ["DashboardHeader"] = { fg = "#98971a" },
        ["DashboardFooter"] = { fg = "#83a598" },
        ["IndentBlanklineContextChar"] = { fg = "#3c3836" },

        ["NvimTreeOpenedFolderName"] = { fg = "#ebdbb2" },
        ["NvimTreeFolderName"] = { fg = "#ebdbb2" },
        ["NvimTreeIndentMarker"] = { fg = "#ebdbb2" },
        ["NvimTreeEmptyFolderName"] = { fg = "#ebdbb2" },

        ["BufferLineFill"] = { fg = "#3c3836", bg = "#3c3836" },
        ["BufferLineBackground"] = { fg = "#ebdbb2", bg = "#1d2021" },
        ["BufferLineSeparatorSelected"] = { fg = "#3c3836", bg = "#282828" },
        ["BufferLineSeparator"] = { fg = "#3c3836", bg = "#1d2021" },
        ["BufferLineSeparatorVisible"] = { fg = "#3c3836", bg = "#282828" },
        ["BufferLineBufferVisible"] = { fg = "#ebdbb2", bg = "#282828" },
        ["BufferLineBufferSelected"] = { fg = "#ebdbb2", bg = "#282828" },
        ["BufferLineCloseButtonVisible"] = { fg = "#ebdbb2", bg = "#282828" },
        ["BufferLineCloseButton"] = { fg = "#ebdbb2", bg = "#1d2021" },
        ["BufferLineCloseButtonSelected"] = { fg = "#ebdbb2", bg = "#282828" },
        ["BufferLineModified"] = { bg = "#1d2021" },
        ["BufferLineModifiedVisible"] = { bg = "#282828" },
        ["BufferLineModifiedSelected"] = { bg = "#282828" },
        ["BufferLineTab"] = { fg = "#ebdbb2", bg = "#1d2021" },
        ["BufferLineTabClose"] = { fg = "#ebdbb2", bg = "#282828" },
        ["BufferLineTabSelected"] = { fg = "#ebdbb2", bg = "#282828" },
        ["BufferLineTabSeparator"] = { fg = "#3c3836", bg = "#1d2021" },
        ["BufferLineTabSeparatorSelected"] = { fg = "#3c3836", bg = "#282828" },
        ["BufferlineDuplicate"] = { bg = "#1d2021" }
      },
      italic = {
        strings = false,
      },
      transparent_mode = true,
    },
    -- Workaround so that highlights for BufferLineDevIcon bg is set properly 
    config = function(_, opts)
      require("gruvbox").setup(opts)

      vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWinEnter", "BufNewFile" }, {
        callback = function()
          vim.schedule(function()
            for _, group in ipairs(vim.fn.getcompletion("BufferLineDevIcon", "highlight")) do
              if not group:lower():find("selected") and not group:lower():find("inactive") then
                local current_hl = vim.api.nvim_get_hl(0, { name = group, link = false })
                vim.api.nvim_set_hl(0, group, {
                  fg = current_hl.fg,
                  bg = "#1d2021",
                })
              end
            end
          end)
        end,
      })
    end,
  },
}

