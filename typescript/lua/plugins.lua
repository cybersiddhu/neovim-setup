-- plugin installation using lazy.nvim
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
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
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    config = function()
      require("config.mini-ai")
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
    "saghen/blink.cmp",
    lazy = false,
    version = "*",
    build = "cargo build --release",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
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
    dependencies = { "stevearc/conform.nvim" },
    config = function()
      require("config.lsp")
    end,
  },
  -- prettier formatting (replaces archived null-ls)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("config.conform")
    end,
  },
  {
    "folke/sidekick.nvim",
    -- load on LspAttach so NES autocmds exist before any keypress
    event = "LspAttach",
    cmd = "Sidekick",
    keys = {
      { "<c-.>",      function() require("sidekick.cli").toggle() end,                              mode = { "n", "t", "i", "x" }, desc = "Sidekick Toggle" },
      { "<leader>aa", function() require("sidekick.cli").toggle() end,                              desc = "Toggle AI CLI" },
      { "<leader>as", function() require("sidekick.cli").select() end,                              desc = "Select AI CLI" },
      { "<leader>ad", function() require("sidekick.cli").close() end,                               desc = "Close AI CLI Session" },
      { "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, desc = "Toggle Claude" },
      { "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end,              mode = { "n", "x" }, desc = "Send This to CLI" },
      { "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end,              desc = "Send File to CLI" },
      { "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end,         mode = { "x" }, desc = "Send Selection to CLI" },
      { "<leader>ap", function() require("sidekick.cli").prompt() end,                              mode = { "n", "x" }, desc = "Sidekick Prompt" },
      { "<Tab>", function()
        -- jump to the NES hunk, or apply it; fall back to normal <Tab>
        if not require("sidekick").nes_jump_or_apply() then return "<Tab>" end
      end, expr = true, desc = "Goto/Apply NES Hunk" },
      { "[h",         function() require("sidekick.nes").jump() end,                                desc = "Jump to NES Hunk" },
      { "]h",         function() require("sidekick.nes").jump() end,                                desc = "Jump to NES Hunk" },
      { "<leader>ah", function() require("sidekick.nes").apply() end,                               desc = "Apply NES Hunk" },
      { "<leader>ax", function() require("sidekick.nes").clear() end,                               desc = "Clear NES" },
    },
    config = function()
      require("config.sidekick")
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
      "marilari88/neotest-vitest",
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
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        enabled = true,
        file_types = { "markdown" },
      })
    end,
  },
  { "NoahTheDuke/vim-just" },
}
