require("neogen").setup({ snippet_engine = "luasnip" })
local utils = require "utils"
utils.map("n", "<Leader>nf", ":lua require('neogen').generate({type = 'func'})<CR>")
utils.map("n", "<Leader>nt", ":lua require('neogen').generate({type = 'type'})<CR>")
