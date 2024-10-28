local repo_name_cache = {}

local function git_repo_name()
  local current_path = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_path, ":h")

  if repo_name_cache[current_dir] then
    return repo_name_cache[current_dir]
  end

  local function find_git_root(dir)
    local git_common_dir = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --git-common-dir')[1]

    if git_common_dir and git_common_dir:find(".bare") then
      local repo_path = vim.fn.fnamemodify(git_common_dir, ":h")
      return vim.fn.fnamemodify(repo_path, ":t")
    end

    local git_toplevel = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel')[1]
    if git_toplevel and git_toplevel ~= '' and vim.fn.isdirectory(git_toplevel) == 1 then
      return vim.fn.fnamemodify(git_toplevel, ":t")
    end

    local parent_dir = vim.fn.fnamemodify(dir, ":h")
    if parent_dir == dir then
      return nil
    else
      return find_git_root(parent_dir)
    end
  end

  local git_root = find_git_root(current_dir)

  if git_root then
    repo_name_cache[current_dir] = git_root
    return git_root
  else
    repo_name_cache[current_dir] = ""
    return ""
  end
end

local function is_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  else
    return "Recording @" .. reg
  end
end

vim.cmd([[
  augroup LualineGitRepoNameRefresh
    autocmd!
    autocmd BufEnter,BufWinEnter,TabEnter * lua repo_name_cache = {}
  augroup END
]])

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
          always_divide_middle = true,
          disabled_filetypes = {
            statusline = { 'NvimTree' },
            winbar = {},
          },
          ignore_focus = { 'NvimTree' },
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { git_repo_name, 'filename' },
          lualine_x = { is_recording, 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end,
  },
}

