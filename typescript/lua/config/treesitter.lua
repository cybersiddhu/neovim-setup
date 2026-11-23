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
  ensure_installed = {
    "javascript", "typescript", "tsx", "jsdoc", "html", "css",
    "dockerfile", "json", "markdown", "toml", "vim", "yaml", "graphql", "just",
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}
