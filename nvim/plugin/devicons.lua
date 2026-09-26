vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-web-devicons" } })

require("nvim-web-devicons").setup({
	override_by_extension = {
		yaml = {
			icon = "",
			color = "#D70000",
			cterm_color = "160",
			name = "Yaml",
		},
		yml = {
			icon = "",
			color = "#D70000",
			cterm_color = "160",
			name = "Yml",
		},
	},
})
