vim.api.nvim_create_autocmd("BufEnter", {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/j-hui/fidget.nvim" } })

		require("fidget").setup({
			opts = {
				progress = {
					ignore = { "ltex" },
				},
				notification = {
					window = {
						winblend = 0,
					},
				},
			},
		})
	end,
})
