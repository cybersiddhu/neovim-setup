local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
local o = vim.o -- to set global options
local bo = vim.bo -- to set buffer-scoped options
local wo = vim.wo -- to set window-scoped options


cmd "syntax enable"
cmd "filetype plugin indent on"
opt.clipboard:append("unnamedplus")
opt.shortmess:append("c")
opt.virtualedit = "onemore"
opt.history = 1000
opt.spell = false
opt.hidden = true
opt.iskeyword:remove("-")
opt.signcolumn = "yes"
opt.cmdheight = 2
opt.updatetime = 300
if fn.has("persistent_undo") then
	opt.undofile = true
	opt.undolevels = 1000
	opt.undoreload = 10000
end

-- UI
o.tabpagemax = 15
cmd "highlight clear SignColumn"
cmd "highlight clear LineNr"
opt.number = true
o.showmatch = true
o.winminheight = 0
opt.ignorecase = true
opt.smartcase = true
o.wildmode = "list:longest:full"
o.whichwrap = "b,s,h,l<,>,[,]"
o.scrolljump = 5
o.scrolloff = 3
wo.list = true
opt.listchars = { nbsp = ".", extends = "#", trail = "·", tab = "▸ " }

-- Formatting
wo.wrap = false
bo.shiftwidth = 4
bo.expandtab = true
bo.tabstop = 4
bo.softtabstop = 4
o.joinspaces = false
o.splitright = true
o.splitbelow = true
o.textwidth = 80
opt.colorcolumn = "81"
cmd "cabbr <expr> %% expand('%:p:h')"
