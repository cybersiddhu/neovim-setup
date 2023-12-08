-- treesitter configuration
--    <Alt-n><Alt-c> to swap with the next class
--    <Alt-p><Alt-c> to swap with the previous class
--    <Alt-n><Alt-f> to swap with the next function
--    <Alt-p><Alt-f> to swap with the previous function
--    <Alt-n><Alt-p> to swap with the next parameter
--    <Alt-p><Alt-p> to swap with the previous parameter
local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    c = "@class.outer",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<A-n><A-%s>", key)] = obj
    p[string.format("<A-p><A-%s>", key)] = obj
  end

  return n, p
end)()

local tree_config = require "nvim-treesitter.configs"
local text_objects = {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    },
  },
  swap = {
    enable = true,
    swap_next = swap_next,
    swap_previous = swap_previous,
  },
  move = {
    enable = true,
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },
  lsp_interop = {
    enable = true,
    border = "none",
    peek_definition_code = {
      ["<leader>df"] = "@function.outer",
      ["<leader>dF"] = "@class.outer",
    },
  },
}
local refactor = {
  highlight_definitions = { enable = true },
  highlight_current_scope = { enable = true },
  smart_rename = {
    enable = true,
    keymaps = {
      smart_rename = "grr",
    },
  },
  navigation = {
    enable = true,
    keymaps = {
      goto_definition = "gnd",
      list_definitions = "gnD",
      list_definitions_toc = "gO",
      goto_next_usage = "<a-*>",
      goto_previous_usage = "<a-#>",
    },
  },
}
tree_config.setup {
  ensure_installed = {
    "dockerfile",
    "json", "markdown", "toml",
    "vim", "yaml", "terraform", "javascript", "tsx", "typescript"
  },
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
  textobjects = text_objects,
  refactor = refactor,
  autotag = { enable = true },
}
