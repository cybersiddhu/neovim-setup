local cmp = require "cmp"
local luasnip = require "luasnip"

local function bufopt()
  return vim.api.nvim_list_bufs()
end
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local function cjc()
  if cmp.visible() then
    cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
  else
    vim.api.nvim_feedkeys("<Down>", "n", true)
  end
end
local function cji(fallback)
  if cmp.visible() then
    cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
  else
    fallback()
  end
end
local function ckc()
  if cmp.visible() then
    cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
  else
    vim.api.nvim_feedkeys(t "<Up>", "n", true)
  end
end
local function cki(fallback)
  if cmp.visible() then
    cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
  else
    fallback()
  end
end

-- nvim-cmp setup
cmp.setup {
  mapping = {
    ["<C-j>"] = cmp.mapping({ c = cjc, i = cji }),
    ["<C-k>"] = cmp.mapping({ c = ckc, i = cki }),
    ["Down"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["Up"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s", "c", }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s", "c", }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer",    option = { get_bufnrs = bufopt } },
    { name = "treesitter" },
    { name = "look" },
    { name = "path" },
    { name = "calc" },
    { name = "spell" },
    { name = "emoji" },
    --		{name = "dictionary"},
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = require("lspkind").cmp_format {
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        treesitter = "[Treesitter]",
        look = "[Look]",
        path = "[Path]",
        spell = "[Spell]",
        calc = "[Calc]",
        emoji = "[Emoji]",
        --  dictionary = "[Dictionary]",
      },
    },
  },
}

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- lsp_document_symbols
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {
      { name = "buffer" },
    }),
})
