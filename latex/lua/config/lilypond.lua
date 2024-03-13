require("nvls").setup({
  lilypond = {
    options = {
      pdf_viewer = "skimpdf",
    },
  },
  latex = {
    options = {
      pdf_viewer = "skimpdf",
    },
  },
})

vim.api.nvim_create_autocmd("BufEnter", {
  command = "syntax sync fromstart",
  pattern = { "*.ly", "*.ily", }
})
