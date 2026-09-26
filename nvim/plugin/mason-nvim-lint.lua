vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function(args)
		local filename = vim.fn.fnamemodify(args.file, ":t")
		if vim.tbl_contains({ "COMMIT_EDITMSG", "MERGE_MSG", "TAG_EDITMSG", "NOTES_EDITMSG", "REBASE_EDITMSG" }, filename) then
			return
		end

		vim.pack.add({
			{ src = "https://github.com/mason-org/mason.nvim" },
			{ src = "https://github.com/mfussenegger/nvim-lint" },
			{ src = "https://github.com/rshkarin/mason-nvim-lint" },
		})

		local mason = require("mason")
		if not mason.has_setup then
			mason.setup()
		end

		require("lint")
		require("mason-nvim-lint").setup({
			automatic_installation = false,
		})
	end,
})
