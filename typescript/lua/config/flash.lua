local flash = require("flash")
local utils = require("utils")

flash.setup({
  labels = "auietsrncbpovdljyxqghf",
  modes = {
    search = {
      enabled = true,
    },
    char = {
      jump_labels = true,
    },
  },
})

local function jump_line_start()
  flash.jump({
    search = { mode = "search", max_length = 0, multi_window = false },
    label = { after = { 0, 0 } },
    pattern = "^",
  })
end

local function jump_word()
  flash.jump({
    pattern = ".",
    search = {
      mode = function(pattern)
        if pattern:sub(1, 1) == "." then
          pattern = pattern:sub(2)
        end
        return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
      end,
      multi_window = false,
    },
  })
end

local function jump_char2()
  flash.jump({
    search = {
      mode = "exact",
      max_length = 2,
      multi_window = false,
    },
  })
end

local function jump_pattern()
  flash.jump({
    search = {
      mode = "search",
      multi_window = false,
    },
  })
end

local function jump_vertical()
  flash.jump({
    search = { mode = "search", max_length = 0, multi_window = false },
    label = { after = { 0, 0 } },
    pattern = "^",
  })
end

utils.map({ "n", "v" }, "<Leader>hL", jump_line_start)
utils.map({ "n", "v" }, "<Leader>hW", jump_word)
utils.map({ "n", "v" }, "<Leader>hC", jump_char2)
utils.map({ "n", "v" }, "<Leader>hP", jump_pattern)
utils.map({ "n", "v" }, "<Leader>hV", jump_vertical)
utils.map({ "n", "v", "o" }, "<Leader>hT", function()
  flash.treesitter()
end)
utils.map({ "o" }, "<Leader>hR", function()
  flash.remote()
end)
