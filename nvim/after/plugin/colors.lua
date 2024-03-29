require("gruvbox").setup({
    terminal_colors = false,
	overrides = {
		["Delimiter"] = { link = "GruvboxOrange" },
	},
	italic = {
		strings = false,
	},
	transparent_mode = true,
})

function ColorMyPencils(color)
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

