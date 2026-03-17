local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end
require("lualine").setup({
	options = {
		theme = "nord",
		component_separators = "|",
    		section_separators = { left = "", right = "" },
	},
	sections = {
    		lualine_a = {
      			{ "mode", separator = { left = "" }, right_padding = 2 },
			{"diagnostics", sources = {"nvim_lsp"}},
    		},
		lualine_b = { 
			{"b:gitsigns_head", icon = ""}, 
			{"diff", source = diff_source },
		},
		lualine_c = {
      {
        function()
          local status = require("sidekick.status").get()
          return status and "󰚩 " or ""
        end,
        cond = function()
          local ok, sidekick = pcall(require, "sidekick.status")
          return ok and sidekick.get() ~= nil
        end,
        color = function()
          local status = require("sidekick.status").get()
          return { fg = (status and status.busy) and "#EBCB8B" or "#81A1C1" }
        end,
      },
      {
        function()
          local sessions = require("sidekick.status").cli()
          return "󱚣 " .. (#sessions > 0 and #sessions or "")
        end,
        cond = function()
          local ok, sidekick = pcall(require, "sidekick.status")
          return ok and #sidekick.cli() > 0
        end,
        color = { fg = "#88C0D0" },
      },
    },
		lualine_x = {""},
		lualine_y = { "fileformat", "filetype", "progress" },
		lualine_z = {
		      { "location", separator = { left = "", right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_c = {"filename"},
		lualine_x = {"encoding","fileformat","filetype"},
	},
  	tabline = {},
  	extensions = {},
})
