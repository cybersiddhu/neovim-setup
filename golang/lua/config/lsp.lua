-- lsp and related configuration
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[c', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']c', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist, opts)
vim.keymap.set('n', '<space>l', vim.diagnostic.setloclist, opts)

local nvim_lsp = require "lspconfig"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local buf_set_keymap = vim.keymap.set
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
local on_attach = function(_, bufnr)
  keymaps_on_attach(bufnr)
end
for _, lsp in ipairs({ "dockerls", "yamlls", "graphql", "marksman" }) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
end

nvim_lsp.golangci_lint_ls.setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  init_options = {
		command = { "golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1" }
	}
}

local on_attach_gopls = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  keymaps_on_attach(bufnr)
end
nvim_lsp.gopls.setup {
  on_attach = on_attach_gopls,
  capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
        unusedvariable = true,
        shadow = true,
        ST1022 = true,
        ST1023 = true,
        ST1018 = true,
        S1006 = true,
        SA5010 = true,
        SA6000 = true,
        ST1012 = true,
        ST1016 = true,
        QF1007 = true,
        QF1006 = true
      },
      codelenses = {
        gc_details = true,
        tidy = true,
        upgrade_dependency = true,

      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  }
}

nvim_lsp.vimls.setup {
  on_attach = require("aerial").on_attach
}
nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
