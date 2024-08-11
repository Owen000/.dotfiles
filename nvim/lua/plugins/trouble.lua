return {
	"folke/trouble.nvim",
    opts = {},
	cmd = "Trouble",
	vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true }),
}

