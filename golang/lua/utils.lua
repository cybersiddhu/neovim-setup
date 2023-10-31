local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.godev_file_finder()
  local opts = { cwd =  os.getenv("XDG_DATA_HOME") , hidden = true }
  local theme = require("telescope.themes").get_ivy()
  require("telescope.builtin").find_files(vim.tbl_extend("force", opts, theme))
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
  local opts = { cwd = vim.fn.expand("~"), hidden = true }
  builtins.file_browser(vim.tbl_extend("force", opts, theme))
end

function M.project_file_manager()
  local builtins = require("telescope").extensions.file_browser
  local theme = require("telescope.themes").get_ivy()
  local opts = { hidden = true }
  builtins.file_browser(vim.tbl_extend("force", opts, theme))
end

return M
