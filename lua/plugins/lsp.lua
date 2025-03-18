return {
    -- Mason: Installer for LSP servers, debuggers, etc.
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- updates registry contents after install
        config = function()
        require("mason").setup({
            ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason-LSPConfig: Bridges Mason with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- Automatically install language servers listed here
        ensure_installed = { "lua_ls", "basedpyright" },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-lspconfig: Configurations for built-in LSP client
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Example configuration for the Lua language server
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },  -- Recognize the 'vim' global
            },
          },
        },
      })

      -- You can add additional language servers here.
      -- For example, if you want to set up Pyright for Python:
      lspconfig.basedpyright.setup({
        settings = {
            python = {
                analysis = {
                    -- Options for type checking: "off", "basic", or "strict"
                    typeCheckingMode = "off",
                    -- Automatically search for module paths
                    autoSearchPaths = true,
                    -- Show diagnostics for the entire workspace
                    diagnosticMode = "workspace",
                },
            },
        },
    })

    end,
  },
}

