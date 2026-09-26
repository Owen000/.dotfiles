vim.api.nvim_create_autocmd("BufEnter", {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/kylechui/nvim-surround" } })
		require("nvim-surround").setup()
	end,
})
