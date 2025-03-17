-- lsp.lua
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Enhance capabilities to work with nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup Lua language server
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Neovim uses LuaJIT
        version = "LuaJIT",
      },
      diagnostics = {
        -- Recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Setup BasedPyright language server
lspconfig.basedpyright.setup({
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        -- Options for type checking: "off", "basic", or "strict"
        typeCheckingMode = "strict",
        -- Automatically search for module paths
        autoSearchPaths = true,
        -- Show diagnostics for the entire workspace
        diagnosticMode = "workspace",
      },
    },
  },
})

