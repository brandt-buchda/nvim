return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                view = {
                    width = 30,
                    side = "left",
                    signcolumn = "no",
                    -- optionally, you can adjust the height or other view settings here
                },
                filters = {
                    dotfiles = false, -- set to true to hide dotfiles
                    custom = { "__pycache__", ".git/" },
                },
                git = {
                    enable = false,
                },
                renderer = {
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        glyphs = {
                            default = "",
                        },
                        web_devicons = {
                            file = {
                                enable = false,
                            },
                        },
                    },
                },
            })

            -- Optional: Key mapping to toggle the tree
            vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
            -- vim.cmd([[]])
        end,
    },
}
