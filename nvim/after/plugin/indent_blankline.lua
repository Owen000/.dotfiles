require("ibl").setup {
    exclude = {
        filetypes = {"dashboard"},
        buftypes = {"terminal"},
    },
}

vim.cmd('highlight IndentBlanklineContextChar guifg=#3c3836')

