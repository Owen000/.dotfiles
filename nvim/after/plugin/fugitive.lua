vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local Rice_Fugitive = vim.api.nvim_create_augroup("Rice_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = Rice_Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({'pull',  '--rebase'})
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if I did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
})

-- Add branch name before commit
local function start_commit_with_branch_name()
    local handle = io.popen("git rev-parse --abbrev-ref HEAD")
    local branch_name = handle:read("*a")
    handle:close()

    branch_name = string.gsub(branch_name, "\n$", "")

    vim.api.nvim_command('Git commit -S')
    vim.cmd("normal! i" .. branch_name .. ": ")
    vim.cmd("normal! a ")
    vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>gc", start_commit_with_branch_name)

