-- copilot-lsp: lightweight LSP backend (replaces zbirenbaum/copilot.lua)
vim.lsp.enable("copilot_ls")

-- NES (Next Edit Suggestion): walk to and accept multi-step Copilot edits
local nes = require("copilot-lsp.nes")

vim.keymap.set("n", "<Tab>", function()
  return nes.walk_cursor_start_edit()
    or (nes.apply_pending_nes() and nes.walk_cursor_end_edit())
end, { expr = true, desc = "Copilot NES: accept suggestion" })

vim.keymap.set("n", "<Esc>", function()
  if nes.is_visible() then
    nes.clear()
    return ""
  end
  return "<Esc>"
end, { expr = true, desc = "Copilot NES: clear suggestion" })
