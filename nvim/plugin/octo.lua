vim.api.nvim_create_user_command("Octo", function(opts)
	vim.pack.add({
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		{ src = "https://github.com/pwntester/octo.nvim" },
	})

	require("octo").setup({
		suppress_missing_scope = {
			projects_v2 = true,
		},
	})

	vim.cmd("Octo " .. opts.args)
end, {
	nargs = "*",
	force = true,
})
