local M = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 
    'nvim-lua/plenary.nvim',
  },
}

M.config = function()
  local harpoon = require('harpoon')
  harpoon:setup({})

  -- basic telescope configuration
  local conf = require('telescope.config').values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require('telescope.pickers')
      .new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
  end

  -- Register all keymaps using vim.keymap.set
  vim.keymap.set('n', '<leader>h', function()
    toggle_telescope(harpoon:list())
  end, { desc = 'Open harpoon window' })

  vim.keymap.set('n', '<leader>y', function()
    local file_name = vim.fn.expand('%:t')
    local notify = require('notify')
    notify('Added ' .. file_name, 'info', { timeout = 1500, title = "Harpoon'd yo ass" })
    harpoon:list():add()
  end, { desc = "Add Harpoon mark" })

  vim.keymap.set('n', '<leader>n', function()
    harpoon:list():clear()
  end, { desc = "Clear Harpoon list" })

  vim.keymap.set('n', '<leader>j', function()
    harpoon:list():next()
  end, { desc = "Cycle to next Harpoon" })

  vim.keymap.set('n', '<leader>k', function()
    harpoon:list():prev()
  end, { desc = "Cycle to prev Harpoon" })
end

return M
