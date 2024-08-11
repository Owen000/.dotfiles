local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	defaults = {
		lazy = true,
	},
	lockfile = vim.fn.stdpath("cache") .. "/lazy-lock.json", -- lockfile generated after running update.
	concurrency = 5,
	install = {
		missing = true,
		colorscheme = { "gruvbox" },
	},
	ui = {
		border = "double",
	},
	checker = {
		enabled = false,
		notify = false,
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
	},
})

