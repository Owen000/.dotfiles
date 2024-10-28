local augroup = vim.api.nvim_create_augroup
local RiceGroup = augroup("Rice", {})
local yank_group = augroup("HighlightYank", {})
local terminal_group = augroup("Terminal", { clear = true })

function R(name)
  require("plenary.reload").reload_module(name)
end

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = RiceGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Terminal settings
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "InsertEnter" }, {
  group = terminal_group,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.cmd("startinsert")
    end
  end,
})

