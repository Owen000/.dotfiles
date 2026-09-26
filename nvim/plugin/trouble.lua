vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/folke/trouble.nvim" } })

		require("trouble").setup()
	end,
})

vim.keymap.set("n", "<leader>vq", "<cmd>Trouble diagnostics<cr>", { silent = true, noremap = true, desc = "Trouble diagnostics" })

vim.keymap.set("n", "<leader>vn", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { silent = true, desc = "Go to Next Diagnostic" })
vim.keymap.set("n", "<leader>vp", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true, desc = "Go to Previous Diagnostic" })
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { silent = true, desc = "Open Diagnostics Float" })
