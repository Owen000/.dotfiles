vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/linrongbin16/gitlinker.nvim" } })

		require("gitlinker").setup({
			opts = {},
			keys = {
				{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			},
		})
	end,
})
vim.keymap.set({ "n", "v" }, "<leader>gy", "<cmd>GitLink<CR>", { desc = "Yank git link" })
