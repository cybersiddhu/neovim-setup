require("sidekick").setup({
  cli = {
    picker = "telescope",
    win = {
      layout = "right",
      split = { width = 90 },
    },
    prompts = {
      texfix    = "Fix LaTeX errors and warnings in {file}",
      texprose  = "Improve clarity and grammar of {this} without changing its LaTeX markup",
      textable  = "Convert {selection} into a booktabs LaTeX table",
    },
  },
  nes = {
    diff = { inline = "words" },
  },
})
