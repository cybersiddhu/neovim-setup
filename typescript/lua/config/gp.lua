require("gp").setup({
  chat_model = { model = "gpt-4", temperature = 0.5, top_p = 1 }
})
require("utils").map("n", "<C-g>e", "<Cmd>GpEnew<CR>", { desc = "GPT Prompt Enew" })
require("utils").map("i", "<C-g>e", "<Cmd>GpEnew<CR>", { desc = "GPT Prompt Enew" })
require("utils").map("v", "<C-g>e", ":<C-u>'<,'>GpEnew<CR>", { desc = "GPT Prompt Visual Enew" })
