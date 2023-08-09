local utils = require "utils"
utils.map("n","<Leader>mp","<Plug>MarkdownPreview", {noremap = false, silent = true})
utils.map("n","<Leader>ms","<Plug>MarkdownPreviewStop", {noremap = false, silent = true})
vim.g.mkdp_echo_preview_url = 1
