return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			exclude = {
				filetypes = { "dashboard" },
				buftypes = { "terminal" },
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},
}
