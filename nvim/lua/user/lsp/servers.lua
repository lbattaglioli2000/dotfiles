-- user/lsp/servers.lua
local M = {}

local servers = {
  "cssls",
  "eslint",
  "intelephense",
  "jsonls",
  "lua_ls",
  "tailwindcss",
  "ts_ls",
  "volar",
  "gopls",
  "pyright",
}

function M.setup()
  local lspconfig = require("lspconfig")
  local handlers = require("user.lsp.handlers")

  local capabilities = handlers.capabilities()
  local on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
  end

  for _, server in ipairs(servers) do
    -- Safely load custom server config from `settings/<server>.lua` if it exists
    local ok, custom_opts = pcall(require, "user.lsp.settings." .. server)
    if not ok then
      custom_opts = {}
    end

    -- Merge the shared on_attach + capabilities
    local opts = vim.tbl_deep_extend("force", {
      on_attach = on_attach,
      capabilities = capabilities
    }, custom_opts)

    lspconfig[server].setup(opts)
  end
end

return M
