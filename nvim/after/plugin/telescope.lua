require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        layout_strategy = "cursor",
      },
    }
  }
}

require("telescope").load_extension("ui-select")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>po', builtin.oldfiles, { silent = true, noremap = true })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>ec', function()
    builtin.find_files({ cwd = vim.fn.expand('~/.config/nvim') })
end, { silent = true, noremap = true })

vim.api.nvim_set_keymap('n', '<C-a>', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

