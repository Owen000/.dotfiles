return {
	{
		"Bekaboo/dropbar.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
			vim.api.nvim_set_hl(0, "WinbarNC", { link = "WinBar" })

			require("dropbar").setup({
				general = {
					enable = function(buf, win)
						if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
							return false
						end

						if #vim.api.nvim_list_wins() > 1 then
							return false
						end

						local buftype = vim.bo[buf].buftype
						local filetype = vim.bo[buf].ft
						if filetype == "dashboard" or buftype == "nofile" then
							return false
						end

						return true
					end,
				},
				bar = {
					sources = function(buf, _)
						local sources = require("dropbar.sources")
						local utils = require("dropbar.utils")

						if vim.bo[buf].ft == "markdown" then
							return { sources.path, sources.markdown }
						end
						if vim.bo[buf].buftype == "terminal" then
							return { sources.terminal }
						end
						return { sources.path, utils.source.fallback({ sources.lsp, sources.treesitter }) }
					end,
				},
			})
		end,
	},
}

