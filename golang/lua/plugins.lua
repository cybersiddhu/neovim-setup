-- plugin installation using packer
return require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- works
  -- treesitter
  use {
    { "nvim-treesitter/nvim-treesitter", run = { ":TSUpdate" } },
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
    { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter-textobjects" },
    { "windwp/nvim-ts-autotag", after = "nvim-treesitter-refactor" },
    { "p00f/nvim-ts-rainbow",
      after = "nvim-ts-autotag",
      config = function()
        require("config.treesitter")
        require("config.folding")
      end
    },
    { "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-ts-rainbow",
      requires = { "b3nj5m1n/kommentary" },
      config = [[require("config.comment")]],
    },
    { "nvim-treesitter/nvim-treesitter-context",
      after = "nvim-ts-context-commentstring",
      config = [[require("config.treesitter_context")]],
    }, -- works
    { "folke/zen-mode.nvim",
      after = "nvim-treesitter-context",
      requires = { "folke/twilight.nvim" },
      config = function()
        require("zen-mode").setup({})
        require("utils").map("n", "<Leader>zm", "<Cmd>ZenMode<CR>")
      end
    },
    { "shaunsingh/nord.nvim",
      event = "VimEnter",
      commit = "78f5f001709b5b321a35dcdc44549ef93185e024",
      config = "vim.cmd[[colorscheme nord]]",
    },
    { "stevearc/aerial.nvim",
      config = [[require("config.aerial")]],
    },
  }
  -- lsp and snipetts

  use {
    { "b0o/schemastore.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp",
      requires = {
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
          config = [[require("config.lsp")]],
        }
      },
    },
    { "hrsh7th/cmp-buffer" }, -- works
    { "f3fora/cmp-spell" }, -- works,
    { "hrsh7th/cmp-calc" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol" },
    { "hrsh7th/cmp-cmdline" },
    --		{"uga-rosa/cmp-dictionary"},
    { "octaltree/cmp-look" },
    { "ray-x/cmp-treesitter" },
    { "onsails/lspkind-nvim" }, -- works
    { "L3MON4D3/LuaSnip",
      requires = {
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
      },
      config = function()
        require("config.autocomplete")
        require("luasnip.loaders.from_vscode").load()
      end,
    }, -- works
  }
  -- telescope
  use {
    { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      config = [[require("config.telescope")]],
    },
    { "nvim-telescope/telescope-symbols.nvim" },
  }
  -- tabline
  use { "romgrk/barbar.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = [[require("config.tabline")]],
  }
  -- git
  use {
    { "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({ current_line_blame = true })
        vim.cmd [[highlight default link GitSignsCurrentLineBlame LineNr]]
        require("utils").map("n", "<Leader>cb", "<Cmd>Gitsigns toggle_current_line_blame<CR>")
      end
    },
    { "rhysd/git-messenger.vim" },
    { "pwntester/octo.nvim",
      config = [[require("config.octo")]],
    },
  }
  -- hop
  use { "phaazon/hop.nvim", config = [[require("config.hop")]] }
  -- notify
  use { "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require("notify")
    end,
  }
  -- statusline
  use { "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    commit = "016a20711ee595a11426f9c1f4ab3e04967df553",
    config = [[require("config.lualine")]],
  }
  -- terminal
  use { "voldikss/vim-floaterm",
    event = "VimEnter",
    config = [[require("config.floaterm")]],
  }
  -- editor configuration
  use { "editorconfig/editorconfig-vim" }
  -- autopair
  use { "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({})
    end
  }
  -- startup screen
  use { "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  }
  -- file explorer
  use { "kyazdani42/nvim-tree.lua",
    config = [[require("config.nvim-tree")]]
  }
  -- extra plugin for formatting
  use { "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("config.null-ls")
    end,
  }
  -- documentation
  use { "danymat/neogen",
    config = [[require("config.neogen")]]
  }
  -- test
  use { "nvim-neotest/neotest",
    requires = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
    },
    config = [[require("config.neotest")]],
  }
  -- semantic highlights
  use { "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  }
  -- vim ui interface
  use { "stevearc/dressing.nvim",
    config = function()
      require("utils").map("n", "<Leader>sw", [[<Cmd>lua require("integration.stackoverflow").open_split()<CR>]])
    end
  }
  -- gpt
  use {
    "Bryley/neoai.nvim",
    config = function()
      require("neoai").setup()
    end
  }
  use {
    "james1236/backseat.nvim",
    config = function()
      require("backseat").setup()
    end
  }
  --text objects
  use { "wellle/targets.vim" }
end)
