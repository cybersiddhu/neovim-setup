local function on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()
    if node.nodes ~= nil then
      api.node.open.edit()
    else
      api.node.open.edit()
      api.tree.close()
    end
  end
  local function vsplit_preview()
    local node = api.tree.get_node_under_cursor()
    if node.nodes ~= nil then
      api.node.open.edit()
    else
      api.node.open.vertical()
    end
    api.tree.focus()
  end
  api.config.mappings.default_on_attach(bufnr)
  -- custom keymaps
  vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
  vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
  vim.keymap.set("n", "h", api.tree.close, opts("Close"))
  vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
end

require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  modified = {
    enable = true
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  on_attach = on_attach,
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_modified = "icon",
    highlight_opened_file = "icon",
    highlight_git = true
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false, -- Turn into false from true by default
  }
})

local utils = require "utils"
utils.map("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>")
utils.map("n", "<Leader>r", "<Cmd>NvimTreeRefresh<CR>")
utils.map("n", "<Leader>nd", "<Cmd>NvimTreeFindFile<CR>")
utils.map("n", "<Leader>no", "<Cmd>NvimTreeFocus<CR>")
