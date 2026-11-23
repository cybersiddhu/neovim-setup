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

local function keymaps_on_attach(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  buf_set_keymap("n", "U", vim.lsp.buf.hover, bufopts)
  buf_set_keymap("n", "S", vim.lsp.buf.signature_help, bufopts)
  buf_set_keymap("n", "pd", vim.lsp.buf.type_definition, bufopts)
  buf_set_keymap("n", "pc", vim.lsp.buf.definition, bufopts)
  buf_set_keymap("n", "pi", vim.lsp.buf.implementation, bufopts)
  buf_set_keymap("n", "pr", vim.lsp.buf.references, bufopts)
  buf_set_keymap("n", "<Leader>pn", vim.lsp.buf.rename, bufopts)
  buf_set_keymap("n", "<Leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)
  buf_set_keymap("x", "<Leader>f", vim.lsp.formatexpr, bufopts)
  buf_set_keymap("v", "<Leader>f", vim.lsp.formatexpr, bufopts)
  buf_set_keymap("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  buf_set_keymap("x", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  buf_set_keymap("v", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  -- native inlay hints (replaces archived simrat39/inlay-hints.nvim)
  buf_set_keymap("n", "<Leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, bufopts)
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

for _, lsp in ipairs({ "yamlls", "marksman", "just" }) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- lua_ls: runtime path and workspace libraries (neovim runtime, plugins,
-- luv types) are supplied by lazydev.nvim; a project .luarc.json still wins
vim.lsp.config("lua_ls", {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false },
      codeLens = { enable = true },
      telemetry = { enable = false },
      completion = {
        callSnippet = "Replace",
        keywordSnippet = "Replace",
      },
      hint = {
        enable = true,
        arrayIndex = "Disable",
        semicolon = "Disable",
        setType = true,
      },
    },
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

vim.lsp.enable("lua_ls")
vim.lsp.enable("yamlls")
vim.lsp.enable("marksman")
vim.lsp.enable("just")
vim.lsp.enable("vimls")
vim.lsp.enable("jsonls")
-- github copilot language server (copilot-language-server --stdio);
-- powers sidekick.nvim next edit suggestions. Sign in with :LspCopilotSignIn
vim.lsp.enable("copilot")
