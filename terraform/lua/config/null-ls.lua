local nls = require "null-ls"
local sources = {
  nls.builtins.formatting.golines.with({
    extra_args = { "-m", "80" },
  }),
  nls.builtins.formatting.prettier.with({
    prefer_local = "node_modules/.bin",
  })

}
nls.setup({ sources = sources })
