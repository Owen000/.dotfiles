vim.api.nvim_create_autocmd("BufEnter", {
	once = true,
	callback = function()
		vim.pack.add({ { src = "https://github.com/windwp/nvim-autopairs" } })

		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = { "string", "source", "string_content", "comment" },
				javascript = { "string", "template_string", "comment" },
				typescript = { "string", "template_string", "comment" },
				go = {
					"interpreted_string_literal",
					"interpreted_string_literal_content",
					"raw_string_literal",
					"raw_string_literal_content",
					"comment",
				},
			},
			map_cr = true,
			map_bs = true,
		})
	end,
})
