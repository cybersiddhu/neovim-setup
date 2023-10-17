local gft = require("guard.filetype")
gft("python"):fmt({ cmd = "isort", stdin = true, args = { "--profile black", "-" } }):append("black")
require('guard').setup({
  -- the only options for the setup function
  fmt_on_save = true,
  -- Use lsp if no formatter was defined for this filetype
  lsp_as_default_formatter = false,
})
