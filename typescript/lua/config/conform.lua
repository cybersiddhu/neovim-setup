-- prettier formatting via conform.nvim
-- conform resolves prettier from the project's node_modules/.bin first,
-- falling back to the globally installed binary.
local prettier = { "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
  formatters_by_ft = {
    javascript = prettier,
    javascriptreact = prettier,
    typescript = prettier,
    typescriptreact = prettier,
    vue = prettier,
    css = prettier,
    scss = prettier,
    html = prettier,
    json = prettier,
    jsonc = prettier,
    yaml = prettier,
    markdown = prettier,
    graphql = prettier,
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})
