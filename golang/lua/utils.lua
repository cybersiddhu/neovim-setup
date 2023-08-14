local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.project_file_finder()
  local theme = require("telescope.themes").get_ivy()
  local builtins = require("telescope.builtin")
  local ok = pcall(builtins.git_files, theme)
  if not ok then
    builtins.find_files(theme)
  end
end

function M.home_file_manager()
  local builtins = require("telescope").extensions.file_browser
  local theme = require("telescope.themes").get_ivy()
  local opt = { cwd = vim.fn.expand("~"), hidden = true }
  builtins.file_browser(vim.tbl_extend("force", opt, theme))
end

function M.project_file_manager()
  local builtins = require("telescope").extensions.file_browser
  local theme = require("telescope.themes").get_ivy()
  local opt = { hidden = true }
  builtins.file_browser(vim.tbl_extend("force", opt, theme))
end

return M
