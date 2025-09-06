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
                        "^data/.*", 
                        "/data/.*",
                        -- Additional patterns:
                        "node_modules/",
                        "addon/",
                        "%.zip$",
                        "%.rar$",
                        "%.7z$",
                        "%.exe$",
                        "%.dll$",
                        "%.so$",
                        "%.log$",
                        "%.tmp$",
                        "%.temp$",
                        "%.cache$",
                        "%.bin$",
                        "%.obj$",
                        "%.o$",
                        "build/",
                        "dist/",
                        "target/",
                        "%.import$",  -- Godot import files
                        "%.uid$",     -- Godot uid files
                    },
                },
            })
            local telescope = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", telescope.find_files, { desc = "Telescope Find Files" })
        end,
    },
}
