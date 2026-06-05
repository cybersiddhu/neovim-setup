require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<C-Space>"] = { "show", "fallback" },
    ["<C-d>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
  },
  snippets = { preset = "luasnip" },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
  },
  sources = {
    default = {
      "lsp", "path", "snippets", "buffer",
      "copilot", "look", "calc", "spell", "treesitter",
    },
    cmdline = { "path", "cmdline" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
      look = {
        name = "look",
        module = "blink.compat.source",
        score_offset = -10,
      },
      calc = {
        name = "calc",
        module = "blink.compat.source",
        score_offset = -10,
      },
      spell = {
        name = "spell",
        module = "blink.compat.source",
        score_offset = -10,
      },
      treesitter = {
        name = "treesitter",
        module = "blink.compat.source",
        score_offset = -20,
      },
    },
  },
})
