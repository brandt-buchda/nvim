return {
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup({
                filetype = {
                    lua = {
                        function()
                            return {
                                exe = "stylua",
                                args = {
                                    "--search-parent-directories",
                                    "--config-path",
                                    vim.fn.expand("~/.config/nvim/format/stylua.toml"),
                                    "--stdin-filepath",
                                    vim.api.nvim_buf_get_name(0),
                                    "--",
                                    "-",
                                },
                                stdin = true,
                            }
                        end,
                    },
                    python = {
                        function()
                            local filename = vim.api.nvim_buf_get_name(0)
                            local root = require("lspconfig.util").root_pattern("pyproject.toml")(filename)
                            return {
                                exe = "black",
                                args = { "--quiet", "--config", root .. "/pyproject.toml", "-" },
                                stdin = true,
                            }
                        end,
                        function()
                            return {
                                exe = "isort",
                                args = { "--quiet", "-" },
                                stdin = true,
                            }
                        end,
                    },
                },
            })

            -- Create autocommands to format on save
            vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = "FormatAutogroup",
                pattern = { "*.lua", "*.py" },
                command = "FormatWrite",
            })
        end,
    },
}
