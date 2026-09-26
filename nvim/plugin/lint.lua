vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/mfussenegger/nvim-lint" } })

		local lint = require("lint")

		lint.linters_by_ft = {
			yaml = { "actionlint" },
			bash = { "shellcheck" },
		}

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Lint buffer" })
	end,
})
