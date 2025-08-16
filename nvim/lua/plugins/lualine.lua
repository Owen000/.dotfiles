local repo_name_cache = {}

local function macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

local function git_repo_name()
  local current_path = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_path, ":h")

  if repo_name_cache[current_dir] then
    return repo_name_cache[current_dir]
  end

  local function find_git_root(dir)
    local git_path = dir .. "/.git"
    if vim.fn.isdirectory(git_path) == 1 then
      return dir
    elseif vim.fn.filereadable(git_path) == 1 then
      local file_content = vim.fn.readfile(git_path)
      local relative_path = file_content[1]:match("gitdir: (.*)")
      if relative_path then
        local full_git_path = vim.fn.fnamemodify(dir .. "/" .. relative_path, ":p")
        if full_git_path:find(".git/worktrees") then
          local worktree_path_parts = vim.split(full_git_path, "/")
          for i, part in ipairs(worktree_path_parts) do
            if part == "worktrees" then
              return worktree_path_parts[i - 1]
            end
          end
        end
        return vim.fn.fnamemodify(full_git_path, ":h:h:t")
      end
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
    git_root = git_root:gsub("%.git$", "")
    repo_name_cache[current_dir] = git_root
    return git_root
  else
    repo_name_cache[current_dir] = ""
    return ""
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
          lualine_x = { macro_recording, 'encoding', 'fileformat', 'filetype' },
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

