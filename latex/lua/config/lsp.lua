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

-- lspconfig's own on_attach defines the server's :Lsp* buffer commands
-- (e.g. :LspTexlabBuild, :LspEslintFixAll); run it before ours instead of
-- replacing it
local function with_default_on_attach(name, fn)
  local default = vim.lsp.config[name] and vim.lsp.config[name].on_attach
  return function(client, bufnr)
    if default then
      default(client, bufnr)
    end
    fn(client, bufnr)
  end
end

for _, lsp in ipairs({ "html", "yamlls", "marksman" }) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- texlab: build with tectonic on save, forward search into Skim,
-- format with latexindent (texlab default)
local texlab_bufmaps = {
  { "<Leader>kb", "<Cmd>LspTexlabBuild<CR>",           "texlab: build" },
  { "<Leader>kv", "<Cmd>LspTexlabForward<CR>",         "texlab: forward search in Skim" },
  { "<Leader>kc", "<Cmd>LspTexlabCleanAuxiliary<CR>",  "texlab: clean auxiliary files" },
  { "<Leader>ke", "<Cmd>LspTexlabChangeEnvironment<CR>", "texlab: change environment" },
}
vim.lsp.config("texlab", {
  on_attach = with_default_on_attach("texlab", function(client, bufnr)
    on_attach(client, bufnr)
    for _, m in ipairs(texlab_bufmaps) do
      buf_set_keymap("n", m[1], m[2], { buffer = bufnr, silent = true, desc = m[3] })
    end
  end),
  capabilities = capabilities,
  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = { "-X", "compile", "%f", "--synctex" },
        onSave = true,
      },
      forwardSearch = {
        -- displayline ships inside Skim.app and is not on $PATH
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "-g", "%l", "%p", "%f" },
      },
      -- chktex lints only when it is installed
      chktex = {
        onOpenAndSave = vim.fn.executable("chktex") == 1,
        onEdit = false,
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

vim.lsp.enable("texlab")
vim.lsp.enable("html")
vim.lsp.enable("yamlls")
vim.lsp.enable("marksman")
vim.lsp.enable("vimls")
vim.lsp.enable("jsonls")
-- github copilot language server (copilot-language-server --stdio);
-- powers sidekick.nvim next edit suggestions. Sign in with :LspCopilotSignIn
vim.lsp.enable("copilot")
