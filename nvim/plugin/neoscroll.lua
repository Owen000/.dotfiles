vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/karb94/neoscroll.nvim" },
		})

		require("neoscroll").setup({})
	end,
})
