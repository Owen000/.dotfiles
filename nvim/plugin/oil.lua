vim.api.nvim_create_autocmd("BufEnter", {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim" } })
		require("oil").setup()
	end,
})
