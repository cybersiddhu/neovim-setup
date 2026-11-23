-- lsp and related configuration
local opts = { noremap = true, silent = true }
local buf_set_keymap = vim.keymap.set
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[c', function()
  vim.diagnostic.jump({ count = -1 })
end, opts)
vim.keymap.set('n', ']c', function()
  vim.diagnostic.jump({ count = 1 })
end, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist, opts)
vim.keymap.set('n', '<space>l', vim.diagnostic.setloclist, opts)

-- prettier (conform) first, any attached lsp formatter as fallback
-- in visual mode conform formats just the selection
local function format()
  require("conform").format({ async = true, lsp_format = "fallback" })
end

local function keymaps_on_attach(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  buf_set_keymap("n", "U", vim.lsp.buf.hover, bufopts)
  buf_set_keymap("n", "S", vim.lsp.buf.signature_help, bufopts)
  buf_set_keymap("n", "pd", vim.lsp.buf.type_definition, bufopts)
  buf_set_keymap("n", "pc", vim.lsp.buf.definition, bufopts)
  buf_set_keymap("n", "pi", vim.lsp.buf.implementation, bufopts)
  buf_set_keymap("n", "pr", vim.lsp.buf.references, bufopts)
  buf_set_keymap("n", "<Leader>pn", vim.lsp.buf.rename, bufopts)
  buf_set_keymap("n", "<Leader>f", format, bufopts)
  buf_set_keymap({ "x", "v" }, "<Leader>f", format, bufopts)
  buf_set_keymap("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  buf_set_keymap("x", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  buf_set_keymap("v", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
end

local on_attach = function(client, bufnr)
  keymaps_on_attach(bufnr)
  if client:supports_method("textDocument/documentHighlight") then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- ts_ls and html leave formatting to prettier (conform.nvim)
local on_attach_no_format = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  on_attach(client, bufnr)
end

for _, lsp in ipairs({ "cssls", "dockerls", "yamlls", "graphql", "marksman", "just", "eslint", "oxlint" }) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

vim.lsp.config("html", {
  on_attach = on_attach_no_format,
  capabilities = capabilities,
})

local ts_inlay_hints = {
  includeInlayParameterNameHints = "literals",
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

-- ts_ls (typescript-language-server) wraps tsserver.js, which ships with
-- TypeScript <= 6. For a TypeScript 7+ project use lspconfig's native "tsc"
-- server instead (`vim.lsp.enable("tsc")`).
vim.lsp.config("ts_ls", {
  on_attach = on_attach_no_format,
  capabilities = capabilities,
  settings = {
    typescript = { inlayHints = ts_inlay_hints },
    javascript = { inlayHints = ts_inlay_hints },
  },
})

vim.lsp.config("vimls", {
  on_attach = require("aerial").on_attach
})
vim.lsp.config("jsonls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.enable("ts_ls")
vim.lsp.enable("eslint")
-- oxlint --lsp, resolved from the project's node_modules/.bin;
-- attaches at the nearest .oxlintrc.json or package.json listing oxlint
vim.lsp.enable("oxlint")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("just")
vim.lsp.enable("dockerls")
vim.lsp.enable("yamlls")
vim.lsp.enable("graphql")
vim.lsp.enable("marksman")
vim.lsp.enable("vimls")
vim.lsp.enable("jsonls")
-- github copilot language server (copilot-language-server --stdio);
-- powers sidekick.nvim next edit suggestions. Sign in with :LspCopilotSignIn
vim.lsp.enable("copilot")
