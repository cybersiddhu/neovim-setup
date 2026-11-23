-- prose-friendly buffer options for TeX, BibTeX and markdown
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tex-writing", { clear = true }),
  pattern = { "tex", "plaintex", "bib", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true -- wrap at word boundaries
    vim.opt_local.conceallevel = 0
  end,
})
