-- user/lsp/handlers.lua
local M = {}

-- 1) This is the function that gets called each time an LSP attaches to a buffer
function M.on_attach(client, bufnr)
  -- Example: disable formatting from certain servers if you plan to use null-ls for that
  -- if client.name == "volar" then
  --   client.server_capabilities.documentFormattingProvider = false
  --   client.server_capabilities.documentRangeFormattingProvider = false
  -- end

  -- Keymaps that apply to every LSP
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", opts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<CR>", opts)
  vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<CR>", opts)
  vim.keymap.set('n', '<Leader>lr', "<cmd>LspRestart<CR>", opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)

  -- If you plan to use inlay hints (Neovim ≥ 0.10)
  if client.server_capabilities.inlayHintProvider and vim.lsp.buf.inlay_hint then
    vim.lsp.buf.inlay_hint(bufnr, true)
  end
end

-- 2) Capabilities (important if using nvim-cmp)
function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  return capabilities
end

-- 3) Optional: global LSP/diagnostic config
function M.setup()
  -- Diagnostic signs
  vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn',  { text = '', texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo',  { text = '', texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint',  { text = '', texthl = 'DiagnosticSignHint' })

  -- Diagnostic config
  vim.diagnostic.config({
    virtual_text = false,
    float = { source = true },
  })
end

return M
