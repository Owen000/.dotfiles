vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function(args)
		local filename = vim.fn.fnamemodify(args.file, ":t")
		if
			vim.tbl_contains(
				{ "COMMIT_EDITMSG", "MERGE_MSG", "TAG_EDITMSG", "NOTES_EDITMSG", "REBASE_EDITMSG" },
				filename
			)
		then
			return
		end

		vim.pack.add({
			{ src = "https://github.com/neovim/nvim-lspconfig" },
			{ src = "https://github.com/mason-org/mason.nvim" },
			{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
			{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
		})

		local servers = { "lua_ls", "gopls" }

		require("mason").setup()

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = {
							"vim",
							"require",
						},
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		vim.lsp.config("gopls", {
			root_dir = function(bufnr, on_dir)
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local root = vim.fs.root(filename, { "go.work", "go.mod", ".git" })
				on_dir(root or vim.fs.dirname(filename))
			end,
		})

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_enable = true,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"delve",
				"stylua",
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰌵",
					[vim.diagnostic.severity.INFO] = "󰋼",
				},
			},
			update_in_insert = false,
			underline = true,
			severity_sort = false,
			float = { border = "rounded" },
		})
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
	callback = function(args)
		local buf = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local function map(lhs, rhs, desc, mode)
			vim.keymap.set(mode or "n", lhs, rhs, { buffer = buf, silent = true, desc = desc })
		end

		if client and client.name == "gopls" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = buf,
				callback = function()
					vim.lsp.buf.code_action({
						context = { only = { "source.organizeImports" } },
						apply = true,
					})
				end,
			})
		end

		map("<leader>va", vim.lsp.buf.code_action, "Show Code Actions")
		map("<leader>vf", function()
			vim.lsp.buf.format({ async = true })
		end, "Format Document")
		map("<leader>vrn", vim.lsp.buf.rename, "Rename Function")
		map("<leader>vrr", vim.lsp.buf.references, "Find References")
		map("<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace Symbol Search")
		map("K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "Show Hover Information")
		map("gd", vim.lsp.buf.definition, "Go to Definition")
		map("gr", vim.lsp.buf.references, "Go to References")
		map("<C-i>", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, "Show Signature Help", "i")
	end,
})
