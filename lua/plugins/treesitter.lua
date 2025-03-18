return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- Automatically update parsers on install
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Specify the parsers you want to install. You can add or remove languages.
                ensure_installed = { "bash", "lua", "python", "javascript", "html", "css" },
                sync_install = false, -- Install languages asynchronously

                highlight = {
                    enable = true, -- Enable Treesitter-based syntax highlighting
                    additional_vim_regex_highlighting = false,
                },

                indent = {
                    enable = true, -- Enable Treesitter-based indentation
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn", -- Start selection with gnn
                        node_incremental = "grn", -- Increment to the upper named parent
                        scope_incremental = "grc", -- Increment to the upper scope (as defined in locals.scm)
                        node_decremental = "grm", -- Decrement to the previous node
                    },
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to text object
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
            })
        end,
    },
}
