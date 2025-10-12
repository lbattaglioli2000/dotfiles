-- user/lsp/settings/pyright.lua
return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",  -- Options: "off", "basic", "strict"
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
