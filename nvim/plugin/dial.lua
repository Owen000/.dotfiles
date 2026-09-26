local loaded = false

local function ensure()
	if loaded then
		return
	end
	loaded = true
	vim.pack.add({ { src = "https://github.com/monaqa/dial.nvim" } })
	local augend = require("dial.augend")
	require("dial.config").augends:register_group({
		default = {
			augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
			augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
			augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
			augend.integer.alias.decimal,
			augend.constant.alias.bool, -- boolean value (true <-> false)
			augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
			augend.constant.new({
				elements = { "&&", "||" },
				word = false,
				cyclic = true,
			}),
		},
	})
end

local function map(mode, lhs, direction, scope)
	vim.keymap.set(mode, lhs, function()
		ensure()
		require("dial.map").manipulate(direction, scope)
	end)
end

map("n", "<C-a>", "increment", "normal")
map("n", "<C-x>", "decrement", "normal")
map("n", "g<C-a>", "increment", "gnormal")
map("n", "g<C-x>", "decrement", "gnormal")
map("v", "<C-a>", "increment", "visual")
map("v", "<C-x>", "decrement", "visual")
map("v", "g<C-a>", "increment", "gvisual")
map("v", "g<C-x>", "decrement", "gvisual")
