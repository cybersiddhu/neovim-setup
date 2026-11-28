require "settings"
require "keymappings"

-- plugins live next to this config (<devenv folder>/nvim/lazy), so each
-- language setup keeps its own plugin versions instead of sharing
-- stdpath("data")/lazy with the others
local lazyroot = vim.fn.stdpath("config") .. "/lazy"
local lazypath = lazyroot .. "/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  root = lazyroot,
  rocks = { enabled = false },
})
