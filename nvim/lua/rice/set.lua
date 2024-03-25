vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.fillchars = { eob = " " }

vim.opt.showmode = false

local auto_save_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

_G.SaveBuffer = function()
    if vim.bo.buftype == "" then
        vim.cmd("silent! update")
    end
end

vim.api.nvim_create_autocmd({ "TextChanged", "BufEnter" }, {
    group = auto_save_group,
    pattern = "*",
    callback = function()
        SaveBuffer()
    end,
})

vim.api.nvim_set_keymap("i", "<Esc>", "<C-\\><C-N>:lua PreserveCursorAndSave()<CR>", { noremap = true, silent = true })

_G.PreserveCursorAndSave = function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    SaveBuffer()
    local line = vim.api.nvim_get_current_line()
    if col >= #line then
        col = #line > 0 and (#line - 1) or 0
    end
    vim.api.nvim_win_set_cursor(0, {row, col})
end


vim.api.nvim_set_keymap('t', '<C-w>h', '<C-\\><C-n><C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-w>j', '<C-\\><C-n><C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-w>k', '<C-\\><C-n><C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-w>l', '<C-\\><C-n><C-w>l', {noremap = true, silent = true})
