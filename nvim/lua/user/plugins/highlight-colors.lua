return {
  'brenoprata10/nvim-highlight-colors',
  config = function()
    require('nvim-highlight-colors').setup({
      -- render = 'first_column',
      -- render = 'foreground',
      render = 'background',
      enable_named_colors = true,
    })
  end,
}
