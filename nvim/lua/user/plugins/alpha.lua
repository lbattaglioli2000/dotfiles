return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for icons
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header
    dashboard.section.header.val = {
      " ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
      " ████╗  ██║██║   ██║██║████╗ ████║",
      " ██╔██╗ ██║██║   ██║██║██╔████╔██║",
      " ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      " ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
      " ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    }

    -- Menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "📄  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "🔎  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "⏰  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("p", "📁  Find project", ":Telescope projects<CR>"),
      dashboard.button("s", "⚙   Settings", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "🙅  Quit", ":qa<CR>"),
    }

    -- Footer
    dashboard.section.footer.val = "I DON'T KNOW WHAT ANY OF THIS SHIT IS AND I'M FUCKING SCARED"

    -- Layout
    dashboard.opts.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
  end,
}
