local formatter = require("formatter")
local util = require("formatter.util")

local prettierdConfig = function()
	return {
		exe = "prettierd",
        args = { util.escape_path(util.get_current_buffer_file_path()) },
		stdin = true,
	}
end

local formatterConfig = {
	go = {
		function()
			return {
				exe = "gofmt",
				stdin = true,
			}
		end,
	},
	yaml = {
		function()
			return {
				exe = "yamlfmt",
				args = { "-in" },
				stdin = true,
			}
		end,
	},
	lua = {
		function()
			return {
				exe = "stylua",
				args = { "-" },
				stdin = true,
			}
		end,
		-- function()
		--   return {
		--     exe = "luafmt",
		--     args = {"--indent-count", 2, "--stdin"},
		--     stdin = true
		--   }
		-- end
	},
	vue = {
		function()
			return {
				exe = "prettierd",
				args = {
					"--stdin-filepath",
					vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
					"--single-quote",
					"--parser",
					"vue",
				},
				stdin = true,
			}
		end,
	},
	rust = {
		-- Rustfmt
		function()
			return {
				exe = "rustfmt",
				args = { "--emit=stdout" },
				stdin = true,
			}
		end,
	},
	swift = {
		-- Swiftlint
		function()
			return {
				exe = "swift-format",
				args = { vim.api.nvim_buf_get_name(0) },
				stdin = true,
			}
		end,
	},
	r = {
		function()
			return {
				exe = "R",
				args = {
					"--slave",
					"--no-restore",
					"--no-save",
					"-e",
					"'con <- file(\"stdin\"); styler::style_text(readLines(con)); close(con)'",
					"2>/dev/null",
				},
				stdin = true,
			}
		end,
	},
	dart = {
		function()
			return {
				exe = "dart",
				args = {
					"format",
				},
				stdin = true,
			}
		end,
	},
	["*"] = {
		-- require("formatter.filetypes.any").lsp_format,
		require('formatter.filetypes.any').substitute_trailing_whitespace()
	},
}
local commonFT = {
	"css",
	"scss",
	"html",
	"java",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"markdown",
	"markdown.mdx",
	"json",
	"xml",
	"svg",
	"svelte",
}
for _, ft in ipairs(commonFT) do
	formatterConfig[ft] = { prettierdConfig }
end
-- Setup functions
formatter.setup({
	logging = true,
	filetype = formatterConfig,
	log_level = 2,
})

vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
    group = 'FormatAutogroup',
    pattern = '*.go',
    callback = function()
        vim.cmd('FormatWrite')
    end
})
