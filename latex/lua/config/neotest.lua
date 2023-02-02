local neotest = require("neotest")
local utils = require "utils"
neotest.setup({
    icons = {
      running = "↻",
    },
    strategies = {
      integrated = {
        width = 180
      },
    },
    adapters = {
      require("neotest-plenary"),
      require("neotest-jest")({jestCommand = "yarn test --"}),
    },
  })

  local mappings = {
    ["<Leader>nr"] = function()
      neotest.run.run(vim.fn.expand("%"))
    end,
    ["<Leader>ns"] = function()
      neotest.run.run({ suite = true })
    end,
    ["<Leader>nn"] = neotest.run.run,
    ["<Leader>nd"] = function()
      neotest.run.run({ strategy = "dap" })
    end,
    ["<Leader>nl"] = neotest.run.run_last,
    ["<Leader>nD"] = function()
      neotest.run.run_last({ strategy = "dap" })
    end,
    ["<Leader>na"] = neotest.run.attach,
    ["<Leader>no"] = function()
      neotest.output.open({ enter = true })
    end,
    ["<Leader>nO"] = function()
      neotest.output.open({ enter = true, short = true })
    end,
    ["<Leader>np"] = neotest.summary.toggle,
    ["<Leader>nm"] = neotest.summary.run_marked,
    ["[n"] = function()
      neotest.jump.prev({ status = "failed" })
    end,
    ["]n"] = function()
      neotest.jump.next({ status = "failed" })
    end,
  }

  for keys, mapping in pairs(mappings) do
    utils.map("n", keys, "", { callback = mapping })
  end
