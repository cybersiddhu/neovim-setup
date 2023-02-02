-- lsp and related configuration
local buf_set_keymap = vim.keymap.set
local nvim_lsp = require "lspconfig"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[c', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']c', vim.diagnostic.goto_next, opts)
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
  buf_set_keymap("x", "<Leader>f", vim.lsp.formatexpr, bufopts)
  buf_set_keymap("v", "<Leader>f", vim.lsp.formatexpr, bufopts)
  buf_set_keymap("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  buf_set_keymap("x", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  buf_set_keymap("v", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  buf_set_keymap("n", "<Leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- generic on attach callback for lsp server
local on_attach = function(_, bufnr)
  keymaps_on_attach(bufnr)
end

-- various lsp servers setup
for _, lsp in ipairs({ "html", "yamlls" }) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
end
-- vim lsp server setup
nvim_lsp.vimls.setup {
  on_attach = require("aerial").on_attach
}
-- tex lsp server setup
nvim_lsp.texlab.setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
        },
        onSave = true
      },
      forwardSearch = {
        executable = "displayline",
        args = { "%l", "%p", "%f" }
      },
      chktex = {
        onOpenAndSave = true
      }
    },
  },
}
