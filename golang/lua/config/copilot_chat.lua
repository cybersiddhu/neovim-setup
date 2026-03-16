require("CopilotChat").setup({
  model = "gpt-4.1",
  auto_insert_mode = true,
  window = {
    layout = "vertical",
    width = 0.45,
  },
})

local map = require("utils").map
map("n", "<Leader>aa", "<Cmd>CopilotChatToggle<CR>")
map("n", "<Leader>ao", "<Cmd>CopilotChatOpen<CR>")
map("n", "<Leader>ax", "<Cmd>CopilotChatClose<CR>")
map("n", "<Leader>ar", "<Cmd>CopilotChatReset<CR>")
map("n", "<Leader>as", "<Cmd>CopilotChatStop<CR>")
map("n", "<Leader>am", "<Cmd>CopilotChatModels<CR>")
map("n", "<Leader>ap", "<Cmd>CopilotChatPrompts<CR>")
