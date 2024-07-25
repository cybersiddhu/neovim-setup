require("octo").setup({ file_panel = { size = 18 }, suppress_missing_scope = { projects_v2 = true } })
local utils = require "utils"
utils.map("n", "<Leader>li", "<Cmd>Octo issue list<CR>")
utils.map("n", "<Leader>lp", "<Cmd>Octo pr list<CR>")
utils.map("n", "<Leader>lg", "<Cmd>Octo gist list<CR>")
