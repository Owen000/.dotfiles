vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/folke/which-key.nvim" },
		})

		local wk = require("which-key")
		wk.setup()

		local labels = {
			{ "<leader>?", desc = "Buffer local keymaps" },

			{ "<leader>b", group = "Buffers" },
			{ "<leader>ba", desc = "Close other buffers" },
			{ "<leader>bd", desc = "Close buffer" },
			{ "<leader>$", desc = "Go to last buffer" },

			{ "<leader>d", desc = "Delete to black hole", mode = { "n", "v" } },
			{ "<leader>D", group = "Debug", mode = { "n", "x" } },
			{ "<leader>Dg", group = "Go" },

			{ "<leader>e", group = "Edit" },
			{ "<leader>ec", desc = "Edit config" },

			{ "<leader>g", group = "Git", mode = { "n", "v" } },
			{ "<leader>gc", desc = "Git commit with branch name" },
			{ "<leader>gh", desc = "Copy Git commit hash" },
			{ "<leader>gp", desc = "Octo PR create" },
			{ "<leader>gs", desc = "Open Git status" },
			{ "<leader>gy", desc = "Yank Git link", mode = { "n", "v" } },

			{ "<leader>j", desc = "Next quickfix item" },
			{ "<leader>k", desc = "Next location item" },

			{ "<leader>p", group = "Pickers" },
			{ "<leader>pb", desc = "Find buffers" },
			{ "<leader>pf", desc = "Find files" },
			{ "<leader>ph", desc = "Help tags" },
			{ "<leader>po", desc = "Old files" },
			{ "<leader>ps", desc = "Grep string" },

			{ "<leader>s", desc = "Substitute word under cursor" },
			{ "<leader>u", desc = "Open undo tree" },
			{ "<leader>v", group = "Visual mode", mode = { "n", "x" } },
			{ "<leader>vb", desc = "Visual block mode", mode = { "n", "x" } },
			{ "<leader>w", desc = "Toggle NvimTree" },
			{ "<leader>x", desc = "Make file executable" },
			{ "<leader>y", desc = "Yank to system clipboard", mode = { "n", "v" } },
			{ "<leader>Y", desc = "Yank line to system clipboard" },

			{ "<C-a>", desc = "Increment value", mode = { "n", "v" } },
			{ "<C-c>", desc = "Change inner word" },
			{ "<C-p>", desc = "Git files" },
			{ "<C-x>", desc = "Decrement value", mode = { "n", "v" } },
			{ "g<C-a>", desc = "Increment value in sequence", mode = { "n", "v" } },
			{ "g<C-x>", desc = "Decrement value in sequence", mode = { "n", "v" } },
		}

		for i = 1, 9 do
			table.insert(labels, { "<leader>" .. i, desc = "Go to buffer " .. i })
		end

		wk.add(labels)

		vim.keymap.set("n", "<leader>?", function()
			wk.show({ global = false })
		end, { desc = "Buffer local keymaps" })
	end,
})
