-- user/lsp/init.lua
local M = {}

function M.setup()
  local handlers = require("user.lsp.handlers")
  local servers  = require("user.lsp.servers")

  -- 1) Set up global LSP/diagnostic stuff
  handlers.setup()

  -- 2) Now set up the servers
  servers.setup()
end

return M
