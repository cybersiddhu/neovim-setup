-- lsp and related configuration
local opts = { noremap = true, silent = true }
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local buf_set_keymap = vim.keymap.set
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
local go_format_group = vim.api.nvim_create_augroup("go-lsp-format", { clear = true })

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
local on_attach = function(_, bufnr)
  keymaps_on_attach(bufnr)
end

for _, lsp in ipairs({ "dockerls", "yamlls", "graphql", "marksman" }) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

vim.lsp.config("golangci_lint_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    command = {
      "golangci-lint",
      "run",
      "--output.text.path=",
      "--output.tab.path=",
      "--output.html.path=",
      "--output.checkstyle.path=",
      "--output.junit-xml.path=",
      "--output.teamcity.path=",
      "--output.sarif.path=",
      "--show-stats=false",
      "--output.json.path=stdout",
    },
  },
})

local on_attach_gopls = function(client, bufnr)
  keymaps_on_attach(bufnr)
  if client:supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = go_format_group, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = go_format_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          async = false,
          filter = function(format_client)
            return format_client.name == "gopls"
          end,
        })
      end,
    })
  end
end

vim.lsp.config("gopls", {
  on_attach = on_attach_gopls,
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      completeUnimported = true,
      staticcheck = true,
      usePlaceholders = true,
      analyses = {
        nilness = true,
        unusedwrite = true,
        useany = true,
        unusedparams = true,
        unreachable = true,
        shadow = true,
      },
      codelenses = {
        generate = true,
        gc_details = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
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

vim.lsp.enable("dockerls")
vim.lsp.enable("yamlls")
vim.lsp.enable("graphql")
vim.lsp.enable("marksman")
vim.lsp.enable("golangci_lint_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("vimls")
vim.lsp.enable("jsonls")
vim.lsp.enable("copilot")
