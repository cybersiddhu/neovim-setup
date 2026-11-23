local ai = require("mini.ai")

ai.setup({
  n_lines = 500,
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
  },
})

local function move(key, side, ai_type, id, method)
  vim.keymap.set("n", key, function()
    require("mini.ai").move_cursor(side, ai_type, id, { search_method = method })
  end)
end

-- function motions
move("]m", "left",  "a", "f", "next")
move("[m",  "left",  "a", "f", "prev")
move("]M", "right", "a", "f", "next")
move("[M",  "right", "a", "f", "prev")

-- class motions
move("]]", "left",  "a", "c", "next")
move("[[",  "left",  "a", "c", "prev")
move("][", "right", "a", "c", "next")
move("[]",  "right", "a", "c", "prev")
