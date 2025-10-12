return {
  "numToStr/Comment.nvim",
  opts = {
    mappings = {
      basic = false,  -- disable the default basic mappings
      extra = false,  -- disable extra mappings as well
    },
  },
  config = function()
    require("Comment").setup()
    local api = require("Comment.api")

    -- Normal mode: toggle comment on current line
    vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, { desc = "Toggle comment" })

    -- Visual mode: toggle comment on selected lines
    vim.keymap.set("x", "<leader>/", function()
      api.toggle.linewise(vim.fn.visualmode())
    end, { desc = "Toggle comment" })
  end,
}
