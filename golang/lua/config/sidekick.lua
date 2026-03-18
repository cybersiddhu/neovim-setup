require("sidekick").setup({
  cli = {
    picker = "telescope",
    win = {
      layout = "right",
      split = { width = 90 },
    },
    prompts = {
      gotest   = "Write table-driven tests for {this} using testify/require",
      goreview = "Review {file} for idiomatic Go, error handling, and performance",
      godoc    = "Add godoc comments to {function}",
    },
  },
  nes = {
    diff = { inline = "words" },
  },
})
