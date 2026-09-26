vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

vim.api.nvim_create_autocmd("BufEnter", {

	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })

		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
			},
			disable_netrw = false,
			hijack_netrw = false,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = false,
				side = "left",
				width = 30,
				preserve_window_proportions = true,
			},
			git = {
				enable = true,
				ignore = false,
			},
			filesystem_watchers = {
				enable = true,
			},
			actions = {
				open_file = {
					resize_window = true,
				},
			},
			renderer = {
				root_folder_label = false,
				highlight_git = true,
				highlight_opened_files = "none",
				indent_markers = {
					enable = true,
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = false,
					},
					glyphs = {
						default = "󰈚",
						symlink = "",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",
							arrow_open = "",
							arrow_closed = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
		})
	end,
})
vim.keymap.set("n", "<leader>w", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
