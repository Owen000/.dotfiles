vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = false

vim.opt.modeline = false

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

vim.api.nvim_set_keymap("i", "<Esc>", "<C-\\><C-N>:lua PreserveCursorAndSave()<CR>", { noremap = true, silent = true, desc = "Save buffer and exit insert mode" })

_G.PreserveCursorAndSave = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  SaveBuffer()
  local line = vim.api.nvim_get_current_line()
  if col >= #line then
    col = #line > 0 and (#line - 1) or 0
  end
  vim.api.nvim_win_set_cursor(0, { row, col })
end

vim.api.nvim_set_keymap("t", "<C-w>h", "<C-\\><C-n><C-w>h", { noremap = true, silent = true, desc = "Navigate to the left window" })
vim.api.nvim_set_keymap("t", "<C-w>j", "<C-\\><C-n><C-w>j", { noremap = true, silent = true, desc = "Navigate to the window below" })
vim.api.nvim_set_keymap("t", "<C-w>k", "<C-\\><C-n><C-w>k", { noremap = true, silent = true, desc = "Navigate to the window above" })
vim.api.nvim_set_keymap("t", "<C-w>l", "<C-\\><C-n><C-w>l", { noremap = true, silent = true, desc = "Navigate to the right window" })

vim.api.nvim_create_augroup("YAMLSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "YAMLSettings",
  pattern = { "yaml", "yml" },
  command = "setlocal indentkeys-=0-",
})

-- Copy Commit Hash util
_G.get_commit_hash = function()
  local Job = require 'plenary.job'
  Job:new({
    command = 'git',
    args = {'rev-parse', 'HEAD'},
    cwd = vim.fn.getcwd(),
    on_stdout = function(_, data)
      if data then
        data = data:gsub("%s+$", "")
        vim.schedule(function()
          vim.fn.setreg('+', data)
          print("Commit Hash Copied")
        end)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.schedule(function()
          print("Error: " .. data)
        end)
      end
    end
  }):start()
end

vim.api.nvim_set_keymap(
  'n',
  '<leader>gh',
  ':lua get_commit_hash()<CR>',
  { noremap = true, silent = true, desc = "Copy Git commit hash to clipboard" }
)


-- workaround for lualine and dashboard conflict

local function is_dashboard_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.bo[buf].filetype
    if filetype == 'dashboard' then
      return true
    end
  end
  return false
end

local function update_statusline_visibility()
  if is_dashboard_open() then
    vim.opt.laststatus = 0
  else
    vim.opt.laststatus = 3
  end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "WinEnter", "BufLeave", "TabEnter", "TabLeave" }, {
  pattern = "*",
  callback = function()
    vim.defer_fn(update_statusline_visibility, 10)
  end,
})

update_statusline_visibility()

-- tmux bar hiding integration

vim.api.nvim_command('autocmd VimEnter * silent !tmux set status off')
vim.api.nvim_command('autocmd VimLeave * silent !tmux set status on')


-- have nvimtree open on dirs
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if directory then
    vim.cmd.cd(data.file)

    require("nvim-tree.api").tree.open()
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(args)
    vim.defer_fn(function() open_nvim_tree(args) end, 0)
  end,
  once = true,
})

vim.o.background = "dark"

vim.cmd("colorscheme gruvbox")
vim.g.theme_id = 1
