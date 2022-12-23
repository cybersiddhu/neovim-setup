require("treesitter-context").setup {
	enable = true,
	max_lines = 0,
	pattern = {
		default = { "class", "function", "method" },
	},
}
require("utils").map("n", "<Leader>xt", "<Cmd>TSContextToggle<CR>")
