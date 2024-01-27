require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.cmd("highlight FoldColumn guifg=" .. vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Comment')), 'fg'))
