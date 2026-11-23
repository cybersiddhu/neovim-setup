local M = {}

function M.setup()
  math.randomseed(os.time())
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end
  local function pick_color()
	local colors = {"String", "Identifier", "Keyword", "Number"}
	return colors[math.random(#colors)]
  end
  local function footer()
    local ok, lazy = pcall(require, "lazy")
    local total_plugins = ok and lazy.stats().count or 0
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local plugins_text = "   "
      .. total_plugins
      .. "  plugins"
      .. "   v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "   "
      .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")
    return plugins_text .. "\n" .. quote
  end

  local dashboard = require "alpha.themes.dashboard"
  dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  }
  dashboard.section.header.opts.hl = pick_color()
  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files theme=ivy<CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("b", "  New buffer", ":tabnew <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles theme=ivy<CR>"),
    dashboard.button("s", "  Restore session", "<Cmd>lua require('persistence').load()<CR>"),
    dashboard.button("S", "󰙅  Select session", "<Cmd>lua require('persistence').select()<CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep theme=ivy<CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
    dashboard.button("u", "  Update plugins", ":Lazy sync<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }
  dashboard.section.buttons.opts.hl = "Keyword"
  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts.hl = "Type"
  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end
return M
