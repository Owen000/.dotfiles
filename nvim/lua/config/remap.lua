-- Key mappings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Next item in quickfix list" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next item in location list" })

vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitute word under cursor" }
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })

vim.keymap.set("n", "yp", function()
  local yanked_text = vim.fn.getreg("0")
  yanked_text = yanked_text:gsub("\n$", "")
  yanked_text = yanked_text:gsub("^%s+", "")
  vim.fn.setreg("p", yanked_text)
  return '"pp'
end, { expr = true })
