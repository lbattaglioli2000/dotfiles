return {
  'rcarriga/nvim-notify',
  priority = 1000, -- Ensure it's loaded early
  config = function()
    local notify = require('notify')
    -- vim.notify = require("notify")
    notify.setup({
      -- background_colour = "#000000",
      -- max_width = 40, -- Default maximum width
      -- max_height = 10, -- Default maximum height
      min_height = 10,
      min_width = 40,
      max_width = 80,
      max_height = 20,
      timeout = 3000,
      stages = 'fade',
      fps = 60,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = 'rounded' })
      end,
    })
  end,
}
