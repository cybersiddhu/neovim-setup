require("hop").setup({ keys = "auietsrncbpovdljyxqghf" })
local utils = require "utils"
utils.map("n", "<Leader>hL", "<Cmd>HopLineStart<CR>")
utils.map("v", "<Leader>hL", "<Cmd>HopLineStart<CR>")
utils.map("v", "<Leader>hW", "<Cmd>HopWord<CR>")
utils.map("n", "<Leader>hW", "<Cmd>HopWord<CR>")
utils.map("n", "<Leader>hC", "<Cmd>HopChar2<CR>")
utils.map("v", "<Leader>hC", "<Cmd>HopChar2<CR>")
utils.map("v", "<Leader>hP", "<Cmd>HopPattern<CR>")
utils.map("n", "<Leader>hP", "<Cmd>HopPattern<CR>")
utils.map("v","<Leader>hV","<Cmd>HopVertical<CR>")
utils.map("n","<Leader>hV","<Cmd>HopVertical<CR>")
