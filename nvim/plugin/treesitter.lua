vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
			{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
		})

		local ts = require("nvim-treesitter")
		ts.setup()

		-- install parsers (async, no-op if already installed)
		ts.install({
			"vimdoc",
			"javascript",
			"typescript",
			"c",
			"lua",
			"rust",
			"go",
			"gotmpl",
		})

		-- indent is experimental on main; disable for these filetypes
		local no_indent = { html = true, yaml = true, go = true }

		local function enable(buf)
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			-- highlighting via core treesitter (silently skips if no parser)
			pcall(vim.treesitter.start, buf)
			local ft = vim.bo[buf].filetype
			if not no_indent[ft] then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("ts_enable", { clear = true }),
			callback = function(args)
				enable(args.buf)
			end,
		})

		-- enable for buffers already open (the one that triggered this, etc.)
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				enable(buf)
			end
		end

		require("treesitter-context").setup({})
	end,
})
