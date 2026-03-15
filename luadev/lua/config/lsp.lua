-- lsp and related configuration
local opts = { noremap = true, silent = true }
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local buf_set_keymap = vim.keymap.set
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

vim.lsp.config("yamlls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      codeLens = {
        enable = true,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Both",
        keywordSnippet = "Both",
      },
      hint = {
        enable = true,
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

vim.lsp.enable("yamlls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("vimls")
vim.lsp.enable("jsonls")
