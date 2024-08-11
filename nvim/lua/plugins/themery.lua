return {
    "zaldih/themery.nvim",
    cmd =  "Themery",
    config = function()
        require("themery").setup({
            themes = {
                {
                    name = "Gruvbox Dark",
                    colorscheme = "gruvbox",
                    before = [[
                        vim.o.background = "dark"
                    ]]
                },
                {
                    name = "Gruvbox Light",
                    colorscheme = "gruvbox",
                    before = [[
                        vim.o.background = "light"
                    ]]
                },
                {
                    name = "Default",
                    colorscheme = "default",
                    before = [[
                        vim.o.background = "dark"
                    ]]
                },
            },
            themeConfigFile = "~/.config/nvim/lua/config/activeTheme.lua",
            livePreview = true,
        })

        local active_theme = loadfile(vim.fn.expand("~/.config/nvim/lua/config/activeTheme.lua"))
        if active_theme then
            active_theme()
        end
    end,
}

