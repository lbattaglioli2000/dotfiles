-- Close buffers without closing the split window.

return {
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>w', ':Bdelete<CR>')
    vim.keymap.set('n', '<Leader>W', ':bufdo Bdelete<CR>')
  end,
}
