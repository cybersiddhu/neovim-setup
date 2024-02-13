require("octo").setup({file_panel = {size = 18}})
local utils = require "utils"
utils.map("n","<Leader>li","<Cmd>Octo issue list<CR>")
utils.map("n","<Leader>lp","<Cmd>Octo pr list<CR>")
utils.map("n","<Leader>lg","<Cmd>Octo gist list<CR>")
utils.map("n","<Leader>or","<Cmd>Octo pr create<CR>")
utils.map("n","<Leader>oi","<Cmd>Octo issue create<CR>")
utils.map("n","<Leader>oe","<Cmd>Octo issue edit<CR>")
