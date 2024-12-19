return {
  {
    "VonHeikemen/lsp-zero.nvim",
    init = function()
      vim.g.lsp_zero_ui_float_border = 0
    end,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      -- Set Fastfile to be detected as Ruby filetype
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = "Fastfile",
        command = "set filetype=ruby",
      })

      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "rust_analyzer",
          "pyright",
          "html",
          "lua_ls",
          "bashls",
          "zk",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      require("lspconfig.base")

      local cmp = require("cmp")
      local ELLIPSIS_CHAR = '…'
      local MAX_LABEL_WIDTH = 20
      local MIN_LABEL_WIDTH = 20
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      -- LuaSnip keybindings
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-L>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-J>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })

      -- CMP setup with formatting and mappings
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered({
            relative = "cursor",
            anchor = "NW",
            row = 1,
            col = 0,
            max_width = 80, -- Optional: Limits the width of the popup.
            max_height = 20, -- Optional: Limits the height of the popup.
          }),
        },
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = function(entry, vim_item)
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
              vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            elseif string.len(label) < MIN_LABEL_WIDTH then
              local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
              vim_item.abbr = label .. padding
            end
            return vim_item
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        preselect = cmp.PreselectMode.Item,
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
          { name = "nvim_lua" },
        },
      })

      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "󰋼", texthl = "DiagnosticSignInfo" })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = false,
        float = { border = "rounded" },
      })

      -- Which-Key bindings for LSP
      local wk = require("which-key")

      wk.add({
        { "<leader>v", group = "LSP" },
        { "<leader>va", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Show Code Actions" },
        { "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Open Diagnostics Float" },
        { "<leader>vf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format Document" },
        { "<leader>vn", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Go to Next Diagnostic" },
        { "<leader>vp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Go to Previous Diagnostic" },
        { "<leader>vr", group = "refactor" },
        -- { "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Function" },
        { "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find References" },
        { "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", desc = "Workspace Symbol Search" },
        { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show Hover Information" },
        { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
        { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to References" },
      })

      wk.add({
        { "<C-i>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Show Signature Help", mode = "i" },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
}

