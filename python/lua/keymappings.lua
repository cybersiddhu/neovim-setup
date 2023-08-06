local utils = require "utils"
local g = vim.g      -- a table to access global variables

g.mapleader = ","
g.maplocalleader = "_"
utils.map("n","<Leader>/",":nohlsearch<CR>", {noremap = false, silent = true})
-- utils.map("","<Leader>fc","/\v^[<\|=>]{7}( .*\|$)<CR>", {noremap = false}) -- find merge conflict markers
-- change directory
utils.map("c","cwd","lcd %:p:h", {noremap = false})
utils.map("c","cd.","lcd %:p:h", {noremap = false})
utils.map("n","<Leader>cd",":cd %:p:h<CR>:pwd<CR>")
utils.map("v","<","<gv")
utils.map("v",">",">gv")
-- Allow using the repeat operator with a visual selection (!)
utils.map("v",".",":normal .<CR>")
-- helpers for edit mode
utils.map("c","%%","<C-R>=expand('%:h').'/'<cr>")
--utils.map("","<Leader>ew" ":e %%",{noremap = false})
-- utils.map("","<Leader>es" ":sp %%",{noremap = false})
-- utils.map("","<Leader>ev" ":vsp %%",{noremap = false})
-- utils.map("","<Leader>et" ":tabe %%",{noremap = false})
utils.map("","<Leader>=","<C-w>=",{noremap = false}) -- adjust viewports to the same size
utils.map("","zl","zL",{noremap = false})
utils.map("","zh","zH",{noremap = false})
