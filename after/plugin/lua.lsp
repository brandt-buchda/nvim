re"quire("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "dartls" },
  automatic_installation = true, -- Optional: automatically install configured servers if not present
})

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

-- Setup Python language server (pyright)
lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- Setup Dart language server (dartls)
lspconfig.dartls.setup({
  capabilities = capabilities,
  -- You can add Dart-specific settings here if needed
})

-- nvim-cmp setup (can be in a separate file like cmp.lua)
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }),
})

