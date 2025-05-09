-- Define the on_attach function for LSP key mappings
local on_attach = function(client, bufnr)
    -- Utility function for setting keymaps for the current buffer
    local function buf_set_keymap(mode, lhs, rhs, opts)
        opts = opts or { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Key mappings for LSP features
    -- Go to definition
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    -- Go to declaration
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    -- Hover to show documentation
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    -- Open diagnostice info
    buf_set_keymap("n", "L", "<cmd>lua vim.diagnostic.open_float()<CR>")
    -- List references
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    -- Go to implementation
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    -- Rename symbol
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    -- Code actions (like quick fixes)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    -- Show signature help (useful during function calls)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
end

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
                ensure_installed = { "lua_ls", "basedpyright", "sqls" },
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
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }, -- Recognize the 'vim' global
                        },
                    },
                },
            })

            -- You can add additional language servers here.
            -- For example, if you want to set up Pyright for Python:
            lspconfig.basedpyright.setup({
                on_attach = on_attach,
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

            require("lspconfig").sqls.setup({
                on_attach = on_attach,
                settings = {
                    sqls = {
                        dialect = "postgresql", -- default value; can be overwritten by pyproject.toml
                    },
                },
                on_new_config = function(new_config, root_dir)
                    local ok, toml = pcall(require, "toml")
                    if not ok then
                        vim.notify("TOML parser not found!", vim.log.levels.ERROR)
                        return
                    end

                    local pyproject_path = root_dir .. "/pyproject.toml"
                    if vim.fn.filereadable(pyproject_path) == 1 then
                        local lines = vim.fn.readfile(pyproject_path)
                        local content = table.concat(lines, "\n")

                        -- Replace toml.parse with toml.decode if needed:
                        local ok, parsed = pcall(toml.parse, content)
                        if not ok then
                            -- If parse isn't available, try decode
                            ok, parsed = pcall(toml.decode, content)
                        end

                        if ok and parsed and parsed.tool and parsed.tool.sqls then
                            local cfg = parsed.tool.sqls
                            new_config.settings.sqls.connections = cfg.connections
                                or new_config.settings.sqls.connections
                            new_config.settings.sqls.dialect = cfg.dialect or new_config.settings.sqls.dialect
                        end
                    end
                end,
            })

            require("lspconfig").dartls.setup({
                on_attach = on_attach,
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- LSP source for nvim-cmp
            { "hrsh7th/cmp-nvim-lsp" },
            -- Snippet engine (optional but recommended)
            { "L3MON4D3/LuaSnip" },
            -- Optional: Buffer, path, and other completion sources
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
        },
        config = function()
            -- Setup nvim-cmp.
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                -- Enable snippet support
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    -- Scroll documentation window up and down
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    -- Trigger completion
                    ["<C-Space>"] = cmp.mapping.complete(),
                    -- Abort completion
                    ["<C-e>"] = cmp.mapping.abort(),
                    -- Confirm selection. If none is selected, the first item will be chosen.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    -- Navigate completion items with Tab and Shift-Tab
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
}
