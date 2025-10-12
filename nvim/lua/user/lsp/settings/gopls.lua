return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      codelenses = {
        generate = true,
        gc_details = true,
      },
      hints = {
        parameterNames = true,
        constantValues = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      gofumpt = true, -- Ensure consistent formatting
    },
  },
}
