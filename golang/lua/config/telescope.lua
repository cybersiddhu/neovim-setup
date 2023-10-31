local tele = require "telescope"
tele.setup({
  pickers = {
    find_files = {
      find_command = {
        "fd", "--unrestricted", "--glob", "--type", "f", "--exclude", ".git"
      }
    }
  }
})
tele.load_extension("fzf")
tele.load_extension("file_browser")
tele.load_extension("aerial")
local utils = require("utils")

utils.map("n", "<Leader>tR", "<Cmd>Telescope aerial theme=ivy<CR>")
utils.map("n", "<Leader>tf", utils.project_file_finder)
utils.map("n", "<Leader>tb", utils.project_file_manager)
utils.map("n", "<Leader>tm", utils.home_file_manager)
utils.map("n", "<Leader>tF", utils.godev_file_finder)
utils.map("n", "<Leader>tg", "<Cmd>Telescope live_grep theme=ivy<CR>")
utils.map("n", "<Leader>th", "<Cmd>Telescope help_tags theme=ivy<CR>")
utils.map("n", "<Leader>tc", "<Cmd>Telescope commands theme=ivy<CR>")
utils.map("n", "<Leader>tu", "<Cmd>Telescope buffers theme=ivy<CR>")
utils.map("n", "<Leader>tC", "<Cmd>Telescope command_history theme=ivy<CR>")
utils.map("n", "<Leader>tS", "<Cmd>Telescope search_history theme=ivy<CR>")
utils.map("n", "<Leader>tl", "<Cmd>Telescope spell_suggest theme=ivy<CR>")
utils.map("n", "<Leader>tr", "<Cmd>Telescope lsp_references theme=ivy<CR>")
utils.map("n", "<Leader>td", "<Cmd>Telescope lsp_document_symbols theme=ivy<CR>")
utils.map("n", "<Leader>ta", "<Cmd>Telescope lsp_code_actions theme=ivy<CR>")
utils.map("n", "<Leader>tA", "<Cmd>Telescope lsp_range_code_actions theme=ivy<CR>")
utils.map("n", "<Leader>ti", "<Cmd>Telescope lsp_implemantations theme=ivy<CR>")
utils.map("n", "<Leader>te", "<Cmd>Telescope lsp_definitions theme=ivy<CR>")
utils.map("n", "<Leader>ty", "<Cmd>Telescope lsp_type_definitions theme=ivy<CR>")
utils.map("n", "<Leader>gC", "<Cmd>Telescope git_commits theme=ivy<CR>")
utils.map("n", "<Leader>gB", "<Cmd>Telescope git_bcommits theme=ivy<CR>")
utils.map("n", "<Leader>gR", "<Cmd>Telescope git_branches theme=ivy<CR>")
utils.map("n", "<Leader>gS", "<Cmd>Telescope git_status theme=ivy<CR>")
utils.map("n", "<Leader>gH", "<Cmd>Telescope git_stash theme=ivy<CR>")
