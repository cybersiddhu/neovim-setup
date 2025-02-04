-- plugin installation using packer
return require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- works
  -- treesitter
  use {
    { "nvim-treesitter/nvim-treesitter",             run = { ":TSUpdate" } },
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
    { "nvim-treesitter/nvim-treesitter-refactor",    after = "nvim-treesitter-textobjects" },
    { "windwp/nvim-ts-autotag",                      after = "nvim-treesitter-refactor" },
    {
      "hiphish/rainbow-delimiters.nvim",
      tag = "v0.7.0",
      after = "nvim-ts-autotag",
      config = function()
        require("config.treesitter")
        require("config.folding")
      end
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      requires = { "numToStr/Comment.nvim" },
      config = [[require("config.comment")]],
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      after = "nvim-ts-context-commentstring",
      config = [[require("config.treesitter_context")]],
    }, -- works
    {
      "shaunsingh/nord.nvim",
      event = "VimEnter",
      config = "vim.cmd[[colorscheme nord]]",
    },
    {
      "stevearc/aerial.nvim",
      config = [[require("config.aerial")]],
    },
  }
  -- lsp and snipetts

  use {
    { "b0o/schemastore.nvim" },
    { "hrsh7th/nvim-cmp" },
    {
      "hrsh7th/cmp-nvim-lsp",
      requires = {
        {
          "neovim/nvim-lspconfig",
          config = [[require("config.lsp")]],
        }
      },
    },
    { "hrsh7th/cmp-buffer" }, -- works
    { "f3fora/cmp-spell" },   -- works,
    { "hrsh7th/cmp-calc" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol" },
    { "hrsh7th/cmp-cmdline" },
    { "octaltree/cmp-look" },
    { "ray-x/cmp-treesitter" },
    { "onsails/lspkind-nvim" }, -- works
    {
      "L3MON4D3/LuaSnip",
      requires = {
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
      },
      run = "make install_jsregexp",
      config = function()
        require("config.autocomplete")
        require("luasnip.loaders.from_vscode").load()
      end,
    }, -- works
  }
  -- telescope
  use {
    { "nvim-telescope/telescope.nvim",             requires = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-file-browser.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      config = [[require("config.telescope")]],
    },
    { "nvim-telescope/telescope-symbols.nvim" },
  }
  -- tabline
  use { "romgrk/barbar.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = [[require("config.tabline")]],
  }
  -- git
  use {
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({ current_line_blame = true })
        vim.cmd [[highlight default link GitSignsCurrentLineBlame LineNr]]
        require("utils").map("n", "<Leader>cb", "<Cmd>Gitsigns toggle_current_line_blame<CR>")
      end
    },
    { "rhysd/git-messenger.vim" },
    {
      "pwntester/octo.nvim",
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
  use { "nvim-tree/nvim-tree.lua",
    config = [[require("config.nvim-tree")]]
  }
  use {
    "antosha417/nvim-lsp-file-operations",
    config = function()
      require("lsp-file-operations").setup()
    end
  }
  -- extra plugin for formatting
  use { "nvimdev/guard.nvim",
    commit = "b066152fe06122b047a6b3ce427a19d8b6e628ce",
    requires = { "nvimdev/guard-collection" },
    config = function()
      require("config.guard")
    end
  }
  -- test
  use { "nvim-neotest/neotest",
    requires = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "nvim-neotest/nvim-nio",
    },
    config = [[require("config.neotest")]],
  }
  -- semantic highlights
  use { "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  }
  -- markdown
  use({
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
        require('render-markdown').setup({
          enabled = true,
          file_types = { "markdown", "Avante" }
        })
    end,
    ft = { "markdown", "Avante" }
})
  -- ai
  use({ "yetone/avante.nvim",
    run = { "make" },
    requires = {
      "stevearc/dressing.nvim",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      require("config.avante")
    end,
  })
  --text objects
  use { "wellle/targets.vim" }
  -- justfile support
  use { "NoahTheDuke/vim-just" }
end)
