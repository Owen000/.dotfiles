return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				separator_style = "slant",
				style_preset = {
					bufferline.style_preset.no_italic,
					bufferline.style_preset.no_bold,
				},
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "dashboard",
						text = "Dashboard",
						highlight = "Directory",
						text_align = "left",
						separator = false,
					},
				},
			},
            -- TODO: tech debt :D move to gruvbox.lua
			highlights = {
				fill = {
					fg = "#3c3836",
					bg = "#3c3836",
				},
				background = {
					fg = "#ebdbb2",
					bg = "#1d2021",
				},
				separator_selected = {
					fg = "#3c3836",
					bg = "#282828",
				},
				separator = {
					fg = "#3c3836",
					bg = "#1d2021",
				},
				separator_visible = {
					fg = "#3c3836",
					bg = "#282828",
				},
				buffer_visible = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				buffer = {
					fg = "#ebdbb2",
				},
				buffer_selected = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				duplicate_selected = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				duplicate_visible = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				duplicate = {
					fg = "#ebdbb2",
					bg = "#1d2021",
				},
				close_button_visible = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				close_button = {
					fg = "#ebdbb2",
					bg = "#1d2021",
				},
				close_button_selected = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				modified = {
					bg = "#1d2021",
				},
				modified_visible = {
					bg = "#282828",
				},
				modified_selected = {
					bg = "#282828",
				},
				tab = {
					fg = "#ebdbb2",
					bg = "#1d2021",
				},
				tab_close = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				tab_selected = {
					fg = "#ebdbb2",
					bg = "#282828",
				},
				tab_separator = {
					fg = "#3c3836",
					bg = "#1d2021",
				},
				tab_separator_selected = {
					fg = "#3c3836",
					bg = "#282828",
				},
			},
		})

		for i = 1, 9 do
			vim.api.nvim_set_keymap(
				"n",
				"<leader>" .. i,
				'<cmd>lua require("bufferline").go_to(' .. i .. ", true)<CR>",
				{ noremap = true, silent = true }
			)
		end

		vim.api.nvim_set_keymap(
			"n",
			"<leader>$",
			'<cmd>lua require("bufferline").go_to(-1, true)<CR>',
			{ noremap = true, silent = true }
		)

		vim.api.nvim_set_keymap("n", "<Leader>bd", ":bdelete<CR>", { noremap = true, silent = true })

		local wk = require("which-key")
		local ignore_mappings = {}

		for i = 1, 9 do
			table.insert(ignore_mappings, { "", desc = "<leader>" .. i, hidden = true })
		end
		table.insert(ignore_mappings, { "", desc = "<leader>$", hidden = true })

		wk.add(ignore_mappings)
	end,
}

