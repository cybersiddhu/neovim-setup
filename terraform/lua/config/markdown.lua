local utils = require "utils"
utils.map("n","<Leader>mp","<Plug>MarkdownPreview", {noremap = false, silent = true})
vim.g.mkdp_refresh_slow = 1
