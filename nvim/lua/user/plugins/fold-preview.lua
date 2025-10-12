return   {
  "anuvyklack/fold-preview.nvim",
  dependencies = "anuvyklack/keymap-amend.nvim",
  config = function()
    require("fold-preview").setup({
      border = "rounded", -- Add a border around the preview
    })
  end,
}
