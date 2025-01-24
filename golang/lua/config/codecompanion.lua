require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "deeprouter",
    },
    inline = {
      adapter = "openai",
    },
  },
  adapters = {
				openai = function()
					return require("codecompanion.adapters").extend("openai", {
						url = "https://openrouter.ai/api",
						env = {
							api_key = "OPENROUTER_API_KEY"
						},
						schema = {
							model = {
								default = "anthropic/claude-3.5-sonnet",
							},
						},
					})
				end,
        deeprouter = function()
					return require("codecompanion.adapters").extend("openai", {
            name = "deeprouter",
						url = "https://openrouter.ai/api",
						env = {
							api_key = "OPENROUTER_API_KEY"
						},
						schema = {
							model = {
								default = "deepseek/deepseek-r1",
							},
						},
					})
				end,

	},
  {
   display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ", -- Prompt used for interactive LLM calls
      provider = "telescope", -- default|telescope|mini_pick
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
  },
 }
})
