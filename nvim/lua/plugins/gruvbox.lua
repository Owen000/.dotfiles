return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			terminal_colors = false,
			overrides = {
				["Delimiter"] = { link = "GruvboxOrange" },
				["DashboardHeader"] = { fg = "#98971a" },
				["DashboardFooter"] = { fg = "#83a598" },
				["IndentBlanklineContextChar"] = { fg = "#3c3836" },
				["NvimTreeOpenedFolderName"] = { fg = "#ebdbb2" },
				["NvimTreeFolderName"] = { fg = "#ebdbb2" },
				["NvimTreeIndentMarker"] = { fg = "#ebdbb2" },
				["NvimTreeEmptyFolderName"] = { fg = "#ebdbb2" },
			},
			italic = {
				strings = false,
			},
			transparent_mode = true,
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
}
