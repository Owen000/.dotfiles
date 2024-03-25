local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "tsserver",
    "rust_analyzer",
    "pyright",
    "html",
    "lua_ls",
    "bashls",
    "zk",
})

lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup()

local lspkind = require("lspkind")
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 100,
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = "...",     -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = false, -- show labelDetails in menu. Disabled by default
        }),
    },
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

lsp.set_sign_icons({
    error = '',
    warn = '',
    hint = '󰌵',
    info = '󰋼'
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "",
        warn = "",
        hint = "󰌵",
        info = "󰋼",
    },
})

lsp.on_attach(function(client, bufnr)
    local wk = require("which-key")

    local lsp_mappings = {
        ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show Hover Information" },
        ["<leader>v"] = {
            name = "LSP",
            ws = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace Symbol Search" },
            d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Diagnostics Float" },
            n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to Next Diagnostic" },
            p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to Previous Diagnostic" },
            a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Show Code Actions" },
            ["r"] = {
                name = "refactor",
                r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find References" },
                n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Function" },
            },
            f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format Document" },
        },
    }

    local lsp_mappings_insert = {
        ["<C-h>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show Signature Help" },
    }

    wk.register(lsp_mappings, { buffer = bufnr })
    wk.register(lsp_mappings_insert, { mode = "i", buffer = bufnr })
end)

vim.diagnostic.config({
    virtual_text = true,
})
