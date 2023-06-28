local nls = require "null-ls"
local sources = {
  nls.builtins.formatting.golines.with({
    extra_args = { "-m", "80" },
  }),
}
nls.setup({ sources = sources })
