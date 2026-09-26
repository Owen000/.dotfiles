vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/folke/flash.nvim" },
		})

		local flash = require("flash")

		flash.setup({
			modes = {
				char = {
					enabled = false,
				},
				search = {
					enabled = false,
				},
			},
		})

		vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { silent = true, desc = "Flash Jump" })
		vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { silent = true, desc = "Flash Treesitter" })
		vim.keymap.set("o", "r", flash.remote, { silent = true, desc = "Flash Remote" })
		vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search, { silent = true, desc = "Flash Treesitter Search" })
		vim.keymap.set("c", "<c-s>", flash.toggle, { silent = true, desc = "Toggle Flash Search" })
	end,
})
