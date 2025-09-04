return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "__pycache__", -- keep ignoring __pycache__
                        "%.csv$", -- always ignore *.csv
                        "%.pdf$", -- always ignore *.pdf
                        "%.PDF$", -- always ignore *.PDF
                        "%.png$", -- always ignore *.png
                        "%.jpeg$", -- always ignore *.jpeg
                        "%.jpg$", -- always ignore *.jpg
                        "^data/.*", -- ignore any “data/…” at the very start
                        "/data/.*", -- ignore any “/data/…” deeper in the path
                    },
                },
            })
            local telescope = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", telescope.find_files, { desc = "Telescope Find Files" })
        end,
    },
}
