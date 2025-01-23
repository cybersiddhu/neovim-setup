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
})
