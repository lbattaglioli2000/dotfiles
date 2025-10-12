return {
  -- Mason: installer for LSPs, DAPs, linters, etc.
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true, -- simple setup() call
  },

  -- Mason LSPConfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      -- Initialize Mason and bridge
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "intelephense",
          "tailwindcss",
          "cssls",
          "jsonls",
          "volar",
          "eslint",
        },
        automatic_installation = true,
      })

      ----------------------------------------------------------------------
      -- LSP Setup (Neovim 0.11+)
      ----------------------------------------------------------------------
      -- Instead of require('lspconfig'), use vim.lsp.config if available
      local ok, lspconfig = pcall(require, "lspconfig")
      local lsp = vim.lsp or {}

      -- Compatibility shim for 0.10 and earlier
      local function setup_server(name, opts)
        if lsp.config then
          -- Neovim 0.11+ way
          lsp.config(name, opts)
        elseif ok and lspconfig[name] then
          -- Legacy fallback
          lspconfig[name].setup(opts)
        end
      end

      -- Example LSP setups
      setup_server("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      setup_server("ts_ls", {})
      setup_server("intelephense", {})
      setup_server("cssls", {})
      setup_server("jsonls", {})
      setup_server("volar", {})
      setup_server("eslint", {})

      -- Tailwind (guard against plugin conflicts)
      local has_tailwind_tools, tailwind_tools = pcall(require, "tailwind-tools")
      if has_tailwind_tools then
        pcall(tailwind_tools.setup, {})
      else
        setup_server("tailwindcss", {})
      end
    end,
  },
}
