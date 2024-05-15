local gft = require("guard.filetype")
gft("go"):fmt("gofumpt"):append("golines")
require('guard').setup({
  -- the only options for the setup function
  fmt_on_save = true,
  -- Use lsp if no formatter was defined for this filetype
  lsp_as_default_formatter = false,
})
