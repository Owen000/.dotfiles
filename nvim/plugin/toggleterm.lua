vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/akinsho/toggleterm.nvim" },
		})

		require("toggleterm").setup({
			open_mapping = [[<C-\>]],
		})

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], opts)
		end

		vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
	end,
})
