require("aerial").setup({
  backends = { "treesitter", "lsp" },
  layout = {
    max_width = 0.5,
    width = 0.4,
    min_width = 0.2,
  }
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
