require("avante_lib").load()
require("avante").setup({
  provider = "openrouter",
  vendors = {
  openrouter = {
    __inherited_from = "openai",
    api_key_name = "OPENROUTER_API_KEY",
    endpoint = "https://openrouter.ai/api",
    model = "deepseek/deepseek-r1",
  },
 }
})
