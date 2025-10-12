-- Pretty comment-boxes!
return {
  "LudoPinelli/comment-box.nvim",
  config = function()
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
    local cb = require("comment-box")
    cb.setup({
      -- type of comments:
      --   - "line":  comment-box will always use line style comments
      --   - "block": comment-box will always use block style comments
      --   - "auto":  comment-box will use block line style comments if
      --              multiple lines are selected, line style comments
      --              otherwise
      comment_style = "line",
      doc_width = 80, -- width of the document
      box_width = 60, -- width of the boxes
      borders = {     -- symbols used to draw a box
        top = "─",
        bottom = "─",
        left = "│",
        right = "│",
        top_left = "╭",
        top_right = "╮",
        bottom_left = "╰",
        bottom_right = "╯",
      },
      line_width = 70, -- width of the lines
      lines = {        -- symbols used to draw a line
        line = "─",
        line_start = "─",
        line_end = "─",
        title_left = "─",
        title_right = "─",
      },
      outer_blank_lines_above = false, -- insert a blank line above the box
      outer_blank_lines_below = false, -- insert a blank line below the box
      inner_blank_lines = false,       -- insert a blank line above and below the text
      line_blank_line_above = false,   -- insert a blank line above the line
      line_blank_line_below = false,   -- insert a blank line below the line
    })


    -- left aligned fixed size box with left aligned text
    keymap({ "n", "v" }, "<Leader>cb", "<Cmd>CBllbox<CR>", opts)

    -- centered adapted box
    keymap({ "n", "v" }, "<Leader>cc", "<Cmd>CBacbox<CR>", opts)

    -- left aligned titled line with left aligned text
    keymap({ "n", "v" }, "<Leader>ct", "<Cmd>llline<CR>", opts)

    -- centered line
    keymap("n", "<Leader>cl", "<Cmd>CBcline<CR>", opts)
    keymap("i", "<M-l>", "<Cmd>CBcline<CR>", opts)

    -- remove a box or a titled line
    keymap({ "n", "v" }, "<Leader>cd", "<Cmd>CBd<CR>", opts)
  end
}
