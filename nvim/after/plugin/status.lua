local builtin = require("statuscol.builtin")
local cfg={
  setopt = true,
  relculright = true,
  ft_ignore = {"NvimTree"},
  segments = {


    { text = { " %s"}, click = "v:lua.ScSa" },
    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa", },

    { text = { builtin.foldfunc, " " },
      click = "v:lua.ScFa",
      hl = "Comment",
    },
  }}


require("statuscol").setup(cfg)
