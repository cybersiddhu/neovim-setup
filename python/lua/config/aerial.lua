require("aerial").setup({
  backends = { "treesitter", "lsp" },
})
vim.keymap.set(
  "n", "<Leader>tt",
  "<Cmd>AerialToggle<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n", "<Leader>ac",
  "<Cmd>AerialCloseAll<CR>",
  { noremap = true, silent = true }
)
