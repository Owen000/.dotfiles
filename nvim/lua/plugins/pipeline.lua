-- disable line numbers for ghactions buffer
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "nofile" then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end
  end
})

return {
  'topaxi/pipeline.nvim',
  keys = {
    { '<leader>ga', '<cmd>Pipeline<cr>', desc = 'Open Github Actions menu' },
  },
  -- optional, you can also install and use `yq` instead.
  build = 'make',
  ---@type GhActionsConfig
  opts = {
    --- The browser executable path to open workflow runs/jobs in
    ---@type string|nil
    browser = nil,
    --- Interval to refresh in seconds
    refresh_interval = 10,
    --- How much workflow runs and jobs should be indented
    indent = 2,
    icons = {
      workflow_dispatch = '⚡️',
      conclusion = {
        success = '✓',
        failure = 'X',
        startup_failure = 'X',
        cancelled = '⊘',
        skipped = '◌',
      },
      status = {
        unknown = '?',
        pending = '○',
        queued = '○',
        requested = '○',
        waiting = '○',
        in_progress = '●',
      },
    },
    highlights = {
      GhActionsRunIconSuccess = { link = 'DiagnosticVirtualTextHint' },
      GhActionsRunIconFailure = { link = 'DiagnosticVirtualTextError' },
      GhActionsRunIconStartup_failure = { link = 'DiagnosticVirtualTextError' },
      GhActionsRunIconPending = { link = 'DiagnosticVirtualTextWarn' },
      GhActionsRunIconRequested = { link = 'DiagnosticVirtualTextWarn' },
      GhActionsRunIconWaiting = { link = 'DiagnosticVirtualTextWarn' },
      GhActionsRunIconIn_progress = { link = 'DiagnosticVirtualTextWarn' },
      GhActionsRunIconQueued = { link = 'DiagnosticVirtualTextWarn' },
      GhActionsRunIconCancelled = { link = 'DiagnosticVirtualTextError' },
      GhActionsRunIconSkipped = { link = 'Comment' },
      GhActionsRunCancelled = { link = 'Comment' },
      GhActionsRunSkipped = { link = 'Comment' },
      GhActionsJobCancelled = { link = 'Comment' },
      GhActionsJobSkipped = { link = 'Comment' },
      GhActionsStepCancelled = { link = 'Comment' },
      GhActionsStepSkipped = { link = 'Comment' },
    },
    split = {
      relative = 'editor',
      position = 'right',
      size = 60,
      win_options = {
        wrap = false,
        number = false,
        foldlevel = nil,
        foldcolumn = '0',
        cursorcolumn = false,
        signcolumn = 'no',
      },
    },
  }
}
