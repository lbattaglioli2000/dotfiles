return {
  {
    -- Add neotest-pest plugin for running PHP tests.
    -- A package is also available for PHPUnit if needed.
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",           -- required async primitives
      "nvim-lua/plenary.nvim",           -- neotest core
      "antoinemadec/FixCursorHold.nvim", -- recommended (CursorHold handling)
      "nvim-treesitter/nvim-treesitter", -- adapter parsing
      "V13Axel/neotest-pest",            -- your Pest adapter
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug nearest test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-pest")({
            pest_cmd = function()
              return vim.fn.getcwd() .. "/vendor/bin/pest"
            end,
            pest_test_path = function()
              return vim.fn.getcwd() .. "/tests"
            end,
          })
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            vim.cmd("copen")
          end
        }
      })
    end
  }
}
