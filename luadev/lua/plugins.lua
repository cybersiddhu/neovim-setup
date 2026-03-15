-- plugin installation using lazy.nvim
return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "windwp/nvim-ts-autotag",
      "p00f/nvim-ts-rainbow",
    },
    config = function()
      require("config.treesitter")
      require("config.folding")
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "b3nj5m1n/kommentary" },
    config = function()
      require("config.comment")
    end,
  },
  {
    "lewis6991/nvim-treesitter-context",
    config = function()
      require("config.treesitter_context")
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    config = function()
      require("zen-mode").setup({})
      require("utils").map("n", "<Leader>zm", "<Cmd>ZenMode<CR>")
    end,
  },
  {
    "shaunsingh/nord.nvim",
    event = "VimEnter",
    config = function()
      vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial")
    end,
  },

  -- lsp and snippets
  { "b0o/schemastore.nvim" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-cmdline",
      "octaltree/cmp-look",
      "ray-x/cmp-treesitter",
      "onsails/lspkind-nvim",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").load()
        end,
      },
    },
    config = function()
      require("config.autocomplete")
    end,
  },
  {
    "simrat39/inlay-hints.nvim",
    config = function()
      require("inlay-hints").setup({
        only_current_line = true,
        eol = { right_align = true },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp")
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-symbols.nvim",
    },
    config = function()
      require("config.telescope")
    end,
  },

  -- tabline
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.tabline")
    end,
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ current_line_blame = true })
      vim.cmd([[highlight default link GitSignsCurrentLineBlame LineNr]])
      require("utils").map("n", "<Leader>cb", "<Cmd>Gitsigns toggle_current_line_blame<CR>")
    end,
  },
  { "rhysd/git-messenger.vim" },
  {
    "pwntester/octo.nvim",
    config = function()
      require("config.octo")
    end,
  },

  -- hop
  {
    "phaazon/hop.nvim",
    config = function()
      require("config.hop")
    end,
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    commit = "016a20711ee595a11426f9c1f4ab3e04967df553",
    config = function()
      require("config.lualine")
    end,
  },

  { "editorconfig/editorconfig-vim" },

  -- autopair
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- startup screen
  {
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  },

  -- file explorer
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("config.nvim-tree")
    end,
  },

  -- documentation
  {
    "danymat/neogen",
    config = function()
      require("config.neogen")
    end,
  },

  -- semantic highlights
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },

  -- my custom plugin
  {
    "cybersiddhu/lua-plugins.nvim",
    dependencies = {
      {
        "voldikss/vim-floaterm",
        event = "VimEnter",
        config = function()
          require("config.floaterm")
        end,
      },
      {
        "stevearc/dressing.nvim",
        config = function()
          require("dressing").setup({ input = { width = 60, prefer_width = 70 } })
        end,
      },
    },
    config = function()
      require("coding-assistant").setup()
    end,
  },

  -- text objects
  { "wellle/targets.vim" },

  -- gpt
  {
    "jackMort/ChatGPT.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("chatgpt").setup()
    end,
  },
  {
    "james1236/backseat.nvim",
    config = function()
      require("backseat").setup()
    end,
  },
}
