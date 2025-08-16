return {
  "polarmutex/git-worktree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "folke/which-key.nvim"
  },
  event = "VeryLazy",
  config = function()
    require('telescope').load_extension('git_worktree')

    local wk = require("which-key")

    wk.add({
      { "<leader>gw", group = "Git Worktree" },

      { "<leader>gwc", function()
          require('telescope').extensions.git_worktree.create_git_worktree {
            prompt_title = "Create a New Git Worktree",
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local actions = require("telescope.actions")
                local selection = action_state.get_current_line()
                require("git-worktree").create_worktree(selection, "master", "origin")
                vim.notify("Created worktree: " .. selection, vim.log.levels.INFO)
                actions.close(prompt_bufnr)
              end)
              return true
            end
          }
        end, desc = "Create Worktree"
      },

      { "<leader>gws", function()
          require('telescope').extensions.git_worktree.git_worktree {
            prompt_title = "Switch Git Worktree",
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local actions = require("telescope.actions")
                local selection = action_state.get_selected_entry()
                require("git-worktree").switch_worktree(selection.path)
                actions.close(prompt_bufnr)
              end)
              return true
            end
          }
        end, desc = "Switch Worktree"
      },

      { "<leader>gwd", function()
          require('telescope').extensions.git_worktree.git_worktree {
            prompt_title = "Delete Git Worktrees",
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local actions = require("telescope.actions")
                local selection = action_state.get_selected_entry()
                require("git-worktree").delete_worktree(selection.path)
                vim.notify("Deleted worktree: " .. selection.path, vim.log.levels.INFO)
                actions.close(prompt_bufnr)
              end)
              return true
            end
          }
        end, desc = "Delete Worktree"
      },
    })
  end
}

