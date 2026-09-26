vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/nvimdev/dashboard-nvim" },
			{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
		})

		require("dashboard").setup({
			theme = "doom",
			shortcut_type = "number",
			config = {

				header = {
					"                                                       ",
					"                                                       ",
					"                                                       ",
					" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
					" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
					" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
					" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					"                                                       ",
					"                                                       ",
					"                                                       ",
					"                                                       ",
				},

				center = {
					{
						icon = "󰈞  ",
						desc = "Find File                              ",
						action = function()
							require("telescope.builtin").find_files()
						end,
						key = "<Leader> p f",
					},
					{
						icon = "󰈢  ",
						desc = "Recently opened files                   ",
						action = function()
							require("telescope.builtin").oldfiles()
						end,
						key = "<Leader> p o",
					},
					{
						icon = "  ",
						desc = "Open Nvim config                        ",
						action = function()
							require("telescope.builtin").find_files({ cwd = vim.fn.expand("~/.config/nvim") })
						end,
						key = "<Leader> e c",
					},
					{
						icon = "  ",
						desc = "New file                                ",
						action = "enew",
						key = "e",
					},
					{
						icon = "󰗼  ",
						desc = "Quit Nvim                               ",
						action = "qa",
						key = "q",
					},
				},
			},
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "dashboard",
	group = vim.api.nvim_create_augroup("dashboard_enter", { clear = true }),
	callback = function()
		vim.keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
		vim.keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
	end,
})
