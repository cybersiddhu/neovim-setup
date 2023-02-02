local nls = require "null-ls"
local prettier = nls.builtins.formatting.prettier.with({
	prefer_local = "node_modules/.bin",
})
nls.setup({sources = {prettier}})
