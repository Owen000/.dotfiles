vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/lukas-reineke/indent-blankline.nvim" } })

		vim.opt.list = true
		vim.opt.listchars = {
			trail = "·",
			tab = "  ",
		}

		require("ibl").setup({
			exclude = {
				filetypes = { "dashboard" },
				buftypes = { "terminal" },
			},
			indent = {
				char = "▎",
				tab_char = "▎",
			},
		})
	end,
})
