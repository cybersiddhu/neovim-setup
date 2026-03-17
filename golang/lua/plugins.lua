-- plugin installation using lazy.nvim
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
      { "nvim-treesitter/nvim-treesitter-refactor", branch = "master" },
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
    },
    config = function()
      require("config.treesitter")
      require("config.folding")
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("config.rainbow_delimiters")
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "numToStr/Comment.nvim" },
    config = function()
      require("config.comment")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    branch = "master",
    config = function()
      require("config.treesitter_context")
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
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("config.copilot")
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
          require("copilot_cmp").setup()
        end,
      },
      {
        "samiulsami/cmp-go-deep",
        dependencies = { "kkharji/sqlite.lua" },
      },
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      require("config.autocomplete")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-symbols.nvim",
    },
    config = function()
      require("config.telescope")
    end,
  },

  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.tabline")
    end,
  },

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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.octo")
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("config.flash")
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 1000,
      })
      vim.notify = function(message, level, opts)
        local notify_opts = opts or {}
        if notify_opts.timeout == nil then
          if level == vim.log.levels.ERROR then
            notify_opts.timeout = 3500
          elseif level == vim.log.levels.WARN then
            notify_opts.timeout = 2200
          else
            notify_opts.timeout = 900
          end
        end
        return notify(message, level, notify_opts)
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config.lualine")
    end,
  },
  {
    "voldikss/vim-floaterm",
    event = "VimEnter",
    config = function()
      require("config.floaterm")
    end,
  },

  { "editorconfig/editorconfig-vim" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.nvim-tree")
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-tree/nvim-tree.lua" },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("config.neotest")
    end,
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    config = function()
      require("render-markdown").setup({
        enabled = true,
        file_types = { "markdown", "Avante" },
      })
    end,
  },
  { "NoahTheDuke/vim-just" },
}
