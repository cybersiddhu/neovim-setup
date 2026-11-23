require("sidekick").setup({
  cli = {
    picker = "telescope",
    win = {
      layout = "right",
      split = { width = 90 },
    },
    prompts = {
      luatest   = "Write busted specs for {this} runnable with plenary.nvim's test harness",
      luareview = "Review {file} for idiomatic Neovim Lua, vim.api usage, and error handling",
      luadoc    = "Add LuaCATS annotations to {function}",
    },
  },
  nes = {
    diff = { inline = "words" },
  },
})
