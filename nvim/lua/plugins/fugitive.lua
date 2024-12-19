return {
  {
    "tpope/vim-fugitive",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { 'Gstatus', 'Gcommit', 'Gpush', 'Gpull' },
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git status" })

      local Rice_Fugitive = vim.api.nvim_create_augroup("Rice_Fugitive", { clear = true })

      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = Rice_Fugitive,
        pattern = "*",
        callback = function()
          if vim.bo.filetype ~= "fugitive" then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr, remap = false, desc = "Git commands in Fugitive" }

          vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
          end, vim.tbl_extend("force", opts, { desc = "Git push" }))

          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({ 'pull', '--rebase' })
          end, vim.tbl_extend("force", opts, { desc = "Git pull with rebase" }))

          vim.keymap.set("n", "<leader>t", ":Git push -u origin ", vim.tbl_extend("force", opts, { desc = "Git push upstream" }))
        end,
      })

      local function start_commit_with_branch_name()
        local handle = io.popen("git rev-parse --abbrev-ref HEAD")
        local branch_name = handle:read("*a"):gsub("\n$", "")
        handle:close()

        vim.cmd('Git commit -S')
        vim.cmd("normal! i" .. branch_name .. ": ")
        vim.cmd("normal! a ")
        vim.cmd("startinsert")
      end

      vim.keymap.set("n", "<leader>gc", start_commit_with_branch_name, { desc = "Git commit with branch name" })
    end
  }
}

