require("package-info").setup()
local utils = require "utils"
utils.map("n","<Leader>ns","<Cmd>PackageInfoShow<CR>")
utils.map("n","<Leader>nh","<Cmd>PackageInfoHide<CR>")
utils.map("n","<Leader>nu","<Cmd>PackageInfoUpdate<CR>")
utils.map("n","<Leader>ni","<Cmd>PackageInfoInstall<CR>")
utils.map("n","<Leader>nv","<Cmd>PackageInfoChangeVersion<CR>")
