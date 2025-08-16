return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local custom_send_to_qflist = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local num_selections = #picker:get_multi_selection()

        if num_selections > 0 then
          actions.send_selected_to_qflist(prompt_bufnr)
        else
          actions.send_to_qflist(prompt_bufnr)
        end
        actions.open_qflist(prompt_bufnr)
      end

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-q>"] = custom_send_to_qflist
            },
            n = {
              ["<C-q>"] = custom_send_to_qflist
            }
          }
        },
        pickers = {
          find_files = {
            hidden = true,
            file_ignore_patterns = { ".git/" },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              layout_strategy = "cursor",
            }),
          },
        },
      })

      telescope.load_extension("ui-select")

      vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
      vim.keymap.set("n", "<leader>po", builtin.oldfiles, { silent = true, noremap = true, desc = "Old files" })
      vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({
          search = vim.fn.input("Grep > "),
          additional_args = function(opts)
            return { "--hidden", "--glob", "!.git" }
          end,
        })
      end, { desc = "Grep string" })
      vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Help tags" })

      vim.keymap.set("n", "<leader>ec", function()
        builtin.find_files({ cwd = vim.fn.expand("~/.config/nvim") })
      end, { silent = true, noremap = true, desc = "Edit config" })

      local wk = require("which-key")

      wk.add({
        { "<leader>p", group = "Telescope" },
      })
    end,
  },
}

