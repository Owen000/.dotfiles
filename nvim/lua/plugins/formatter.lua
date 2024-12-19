return {
  {
    'mhartington/formatter.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local formatter = require("formatter")
      local util = require("formatter.util")

      local prettierdConfig = function()
        return {
          exe = "prettierd",
          args = { util.escape_path(util.get_current_buffer_file_path()) },
          stdin = true,
        }
      end

      -- Define formatter configurations
      local formatterConfig = {
        go = {
          function()
            return {
              exe = "gofmt",
              stdin = true,
            }
          end,
        },
        yaml = {
          function()
            return {
              exe = "yamlfmt",
              args = { "-in" },
              stdin = true,
            }
          end,
        },
        lua = {
          function()
            return {
              exe = "stylua",
              args = {
                "--search-parent-directories",
                "--stdin-filepath",
                util.escape_path(util.get_current_buffer_file_path()),
                "--",
                "-",
              },
              stdin = true,
            }
          end,
        },
        vue = {
          function()
            return {
              exe = "prettierd",
              args = {
                "--stdin-filepath",
                vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                "--single-quote",
                "--parser",
                "vue",
              },
              stdin = true,
            }
          end,
        },
        rust = {
          function()
            return {
              exe = "rustfmt",
              args = { "--emit=stdout" },
              stdin = true,
            }
          end,
        },
        swift = {
          function()
            return {
              exe = "swift-format",
              args = { vim.api.nvim_buf_get_name(0) },
              stdin = true,
            }
          end,
        },
        r = {
          function()
            return {
              exe = "R",
              args = {
                "--slave",
                "--no-restore",
                "--no-save",
                "-e",
                "'con <- file(\"stdin\"); styler::style_text(readLines(con)); close(con)'",
                "2>/dev/null",
              },
              stdin = true,
            }
          end,
        },
        dart = {
          function()
            return {
              exe = "dart",
              args = {
                "format",
              },
              stdin = true,
            }
          end,
        },
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace
        },
      }

      local commonFT = {
        "css",
        "scss",
        "html",
        "java",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "markdown",
        "markdown.mdx",
        "json",
        "xml",
        "svg",
        "svelte",
      }

      for _, ft in ipairs(commonFT) do
        formatterConfig[ft] = { prettierdConfig }
      end

      formatter.setup({
        logging = false,
        log_level = vim.log.levels.WARN,
        filetype = formatterConfig,

        hooks = {
          on_format = function(result)
            if result and result.exe and result.exe ~= "sed" then
              vim.notify("Formatting with " .. result.exe, vim.log.levels.INFO)
            end
          end,
        }
      })

      vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = 'FormatAutogroup',
        pattern = '*',
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          if not bufname:match("^octo://") then
            vim.cmd('FormatWrite')
          end
        end
      })
    end,
  }
}

