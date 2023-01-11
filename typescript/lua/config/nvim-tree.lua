require("nvim-tree").setup {
  disable_netrw = true,
  hijack_netrw = true,
  update_to_buf_dir = { enable = false },
  filters = {
    custom = { ".git" },
  },
}
local utils = require "utils"
utils.map("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>")
utils.map("n", "<Leader>r", "<Cmd>NvimTreeRefresh<CR>")
utils.map("n", "<Leader>nd", "<Cmd>NvimTreeFindFile<CR>")
utils.map("n", "<Leader>no", "<Cmd>NvimTreeFocus<CR>")
