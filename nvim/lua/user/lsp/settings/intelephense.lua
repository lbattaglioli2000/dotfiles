-- user/lsp/settings/intelephense.lua
return {
  settings = {
    files = {
      maxSize = 5000000, -- Increase max file size for larger projects
    },
    diagnostics = {
      enable = true,
    },
    telemetry = {
      enable = false,
    },
    environment = {
      phpVersion = "8.4", -- Adjust for your project
    },
    completion = {
      fullyQualifyGlobalConstantsAndFunctions = true,
    },
  }
}
