require("sidekick").setup({
  cli = {
    picker = "telescope",
    win = {
      layout = "right",
      split = { width = 90 },
    },
    prompts = {
      tstest   = "Write unit tests for {this} using vitest",
      tsreview = "Review {file} for idiomatic TypeScript, type safety, and error handling",
      tsdoc    = "Add TSDoc comments to {function}",
    },
  },
  nes = {
    diff = { inline = "words" },
  },
})
