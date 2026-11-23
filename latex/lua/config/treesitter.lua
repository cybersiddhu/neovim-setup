-- Workaround: nvim 0.12 frees C nodes before injection directive handlers run;
-- the Lua object passes `if not node` but node:range() crashes on the dead pointer.
do
  local orig = vim.treesitter.get_node_text
  vim.treesitter.get_node_text = function(node, source, opts)
    local ok, result = pcall(orig, node, source, opts)
    return ok and result or ""
  end
end

local tree_config = require "nvim-treesitter.configs"
tree_config.setup {
  -- "latex" is omitted: its parser must be generated with the tree-sitter
  -- CLI; vim's built-in tex syntax handles highlighting instead
  ensure_installed = {
    "bibtex", "html", "vim", "vimdoc", "yaml", "json", "markdown", "markdown_inline",
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}
