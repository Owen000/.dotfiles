require("rice.set")
require("rice.remap")
require("rice.lazy")
require("rice.lazy_settings")

local augroup = vim.api.nvim_create_augroup
local RiceGroup = augroup('Rice', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = RiceGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_exec([[
  augroup Terminal
    autocmd!
    autocmd TermOpen,TermEnter,InsertEnter * if &buftype == 'terminal' | setlocal nonumber norelativenumber | startinsert | endif
  augroup END
]], false)

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.fn.sign_define(
  "LspDiagnosticsSignError",
  { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
)

