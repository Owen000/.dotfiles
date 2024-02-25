local bufferline = require('bufferline')
bufferline.setup({
    options = {
        separator_style = 'slant',
        style_preset = {
            bufferline.style_preset.no_italic,
            bufferline.style_preset.no_bold
        }
    },
    highlights = {
        fill = {
            fg = '#3c3836',
            bg = '#3c3836',
        },
        background = {
            fg = '#ebdbb2',
            bg = '#1d2021',
        },
        separator_selected = {
            fg = '#3c3836',
            bg = '#282828',
        },
        separator = {
            fg = '#3c3836',
            bg = '#1d2021'
        },
        separator_visible = {
            fg = '#3c3836',
            bg = '#282828',
        },
        buffer_visible = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        buffer = {
            fg = '#ebdbb2',
        },
        buffer_selected = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        duplicate_selected = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        duplicate_visible = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        duplicate = {
            fg = '#ebdbb2',
            bg = '#1d2021',
        },
        close_button_visible = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        close_button = {
            fg = '#ebdbb2',
            bg = '#1d2021',
        },
        close_button_selected = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        modified = {
            bg = '#1d2021',
        },
        modified_visible = {
            bg = '#282828',
        },
        modified_selected = {
            bg = '#282828',
        },
        tab = {
            fg = '#ebdbb2',
            bg = '#1d2021',
        },
        tab_close = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        tab_selected = {
            fg = '#ebdbb2',
            bg = '#282828',
        },
        tab_separator = {
            fg = '#3c3836',
            bg = '#1d2021',
        },
        tab_separator_selected = {
            fg = '#3c3836',
            bg = '#282828',
        },
    }
})

_G.silent_goto_buffer = function(buf_num)
    vim.api.nvim_exec("silent! BufferLineGoToBuffer " .. buf_num, false)
    vim.api.nvim_out_write("\r")
end

for i = 1, 9 do
    vim.api.nvim_set_keymap("n", "<Leader>" .. i, ":lua _G.silent_goto_buffer(" .. i .. ")<CR>", { noremap = true, silent = true })
end

vim.api.nvim_set_keymap('n', '<Leader>bd', ':bdelete<CR>', { noremap = true, silent = true })
