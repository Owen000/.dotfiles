vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/saghen/blink.lib" },
			{ src = "https://github.com/rafamadriz/friendly-snippets" },
			{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
		})

		local function in_lua_string()
			if vim.bo.filetype ~= "lua" then
				return false
			end

			local ok, node = pcall(vim.treesitter.get_node)
			while ok and node do
				if node:type():find("string") then
					return true
				end
				node = node:parent()
			end

			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
			local before_cursor = line:sub(1, col)
			local quote = nil

			for i = 1, #before_cursor do
				local char = before_cursor:sub(i, i)
				local prev = before_cursor:sub(i - 1, i - 1)

				if (char == '"' or char == "'") and prev ~= "\\" then
					quote = quote == char and nil or quote or char
				end
			end

			return quote ~= nil
		end

		local function keep_lua_string_completion_local(_, items)
			if not in_lua_string() then
				return items
			end

			for _, item in ipairs(items) do
				local text = (item.textEdit and item.textEdit.newText)
					or item.textEditText
					or item.insertText
					or item.label
				local string_text = text and text:match([[^['"]([%a_][%w_]*)['"]$]])

				if item.client_name == "lua_ls" and string_text then
					item.client_id = nil
					item.command = nil
					item.data = nil
					item.textEdit = nil
					item.textEditText = nil
					item.additionalTextEdits = nil
					item.label = string_text
					item.filterText = string_text
					item.insertText = string_text
					item.insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText
				end
			end

			return items
		end

		local cmdline_tab_completed = nil
		local cmdline_tab_cycle_line = nil

		local function remember_cmdline_completion()
			cmdline_tab_completed = vim.fn.getcmdline()
			cmdline_tab_cycle_line = nil
		end

		local function accept_cmdline_completion(cmp)
			return cmp.select_and_accept({
				callback = remember_cmdline_completion,
			})
		end

		local function select_next_cmdline_completion(cmp)
			local function select_next()
				if cmp.select_next({ auto_insert = true }) then
					cmdline_tab_cycle_line = vim.fn.getcmdline()
					return true
				end
				return false
			end

			if cmp.is_menu_visible() then
				return select_next()
			end

			return cmp.show({
				callback = select_next,
			})
		end

		local function tab_complete_cmdline(cmp)
			local cmdline = vim.fn.getcmdline()

			if cmdline_tab_cycle_line and cmdline == cmdline_tab_cycle_line then
				return select_next_cmdline_completion(cmp)
			end

			cmdline_tab_cycle_line = nil

			if cmdline_tab_completed and cmdline == cmdline_tab_completed then
				return select_next_cmdline_completion(cmp)
			end

			cmdline_tab_completed = nil

			if cmp.is_menu_visible() then
				return accept_cmdline_completion(cmp)
			end

			return cmp.show({
				callback = function()
					accept_cmdline_completion(cmp)
				end,
			})
		end

		vim.api.nvim_create_autocmd("CmdlineLeave", {
			group = vim.api.nvim_create_augroup("BlinkCmdlineTabState", { clear = true }),
			callback = function()
				cmdline_tab_completed = nil
				cmdline_tab_cycle_line = nil
			end,
		})

		local cmp = require("blink.cmp")
		if not cmp.library_available() then
			cmp.build():wait(120000)
		end

		cmp.setup({
			keymap = {
				preset = "enter",
				["<CR>"] = { "accept", "fallback" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},

			completion = {
				menu = {
					auto_show = true,
					auto_show_delay_ms = 0,
					border = "rounded",
					scrollbar = false,
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
				ghost_text = {
					enabled = true,
					show_with_selection = true,
					show_without_selection = false,
					show_with_menu = true,
					show_without_menu = false,
				},
			},

			cmdline = {
				keymap = {
					["<Tab>"] = { tab_complete_cmdline, "fallback" },
				},
				completion = {
					menu = {
						auto_show = false,
						auto_show_delay_ms = 0,
					},
					ghost_text = {
						show_without_menu = false,
					},
				},
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						transform_items = keep_lua_string_completion_local,
					},
				},
			},

			fuzzy = { implementation = "rust" },
		})

		local function transparent_menu()
			for _, name in ipairs({ "BlinkCmpMenu", "BlinkCmpMenuBorder" }) do
				local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
				vim.api.nvim_set_hl(0, name, { fg = hl.fg, bg = "NONE" })
			end
		end

		transparent_menu()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.schedule(transparent_menu)
			end,
		})
	end,
})
