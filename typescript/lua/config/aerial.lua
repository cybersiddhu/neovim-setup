require("aerial").setup({
	backends = {"treesitter","lsp"},
	on_attach = function(bufnr)
 	   vim.api.nvim_buf_set_keymap(
	   	bufnr, "n", "<Leader>tt", 
	   	"<Cmd>AerialToggle<CR>", 
	   	{noremap = true, silent = true}
	   )
	end
})
