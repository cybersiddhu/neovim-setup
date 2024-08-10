require("gp").setup({
  providers = {
    openrouter = {
      disable = false,
      endpoint = "https://openrouter.ai/api/v1/chat/completions",
      secret = os.getenv("OPENROUTER_API_KEY"),
    },
  },
  agents = {
    -- Disable ChatGPT 3.5
    {
      name = "ChatGPT3-5",
      disable = true,
    },
    {
      name = "CodeGPT3-5",
      disable = true,
    },
    {
      name = "ChatGPT4o-mini",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o-mini", temperature = 0.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are a helpful assistant.\n"
          .. "You can help me by answering my questions.\n"
          .. "You can also ask me questions.\n",
    },
    {
      name = "ChatGPT4o",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o", temperature = 0.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are a helpful assistant.\n"
          .. "You can help me by answering my questions.\n"
          .. "You can also ask me questions.\n",
    },
    {
      name = "CodeGPT4-mini",
      chat = false,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o-mini", temperature = 0.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are an AI working as a code editor.\n\n"
          .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
          .. "START AND END YOUR ANSWER WITH:\n\n```",
    },
    {
      name = "CodeGPT4",
      chat = false,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o", temperature = 0.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are an AI working as a code editor.\n\n"
          .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
          .. "START AND END YOUR ANSWER WITH:\n\n```",
    },
    {
      provider = "openrouter",
      name = "CodeClaude35-sonnet",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "anthropic/claude-3.5-sonnet", temperature = 0.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are an AI working as a code editor.\n\n"
          .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
          .. "START AND END YOUR ANSWER WITH:\n\n```",
    }
  },
})
require("utils").map("n", "<C-g>e", "<Cmd>GpEnew<CR>", { desc = "GPT Prompt Enew" })
require("utils").map("i", "<C-g>e", "<Cmd>GpEnew<CR>", { desc = "GPT Prompt Enew" })
require("utils").map("v", "<C-g>e", ":<C-u>'<,'>GpEnew<CR>", { desc = "GPT Prompt Visual Enew" })
require("utils").map("n", "<C-g>p", "<Cmd>GpPrepend<CR>", { desc = "GPT Prompt Prepend" })
require("utils").map("i", "<C-g>p", "<Cmd>GpPrepend<CR>", { desc = "GPT Prompt Prepend" })
require("utils").map("v", "<C-g>p", ":<C-u>'<,'>GpPrepend<CR>", { desc = "GPT Prompt Prepend" })
