return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    "__pychache__",
                },
            },
        }),
        config = function()
            local telescope = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", telescope.find_files, { desc = "Telescope Find Files" })
        end,
    },
}
