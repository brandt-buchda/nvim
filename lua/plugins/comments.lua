return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                -- ROUTE: API endpoints or navigation-related code
                ROUTE = {
                    icon = "",
                    color = "info", -- blue/cyan
                    alt = { "ENDPOINT", "API" },
                },

                -- SECTION: Logical divisions or code sections
                SECTION = {
                    icon = "",
                    color = "hint", -- green
                    alt = { "SEC", "PART" },
                },

                -- MODEL: Data schemas, database tables, and structured models
                MODEL = {
                    icon = "",
                    color = "test", -- purple/violet
                    alt = { "SCHEMA", "TABLE", "DATA" },
                },

                -- IMPORTANT: Crucial information needing immediate attention
                IMPORTANT = {
                    icon = "",
                    color = "warning", -- yellow/orange
                    alt = { "IMPT", "!", "CRITICAL" },
                },
            },

            highlight = {
                before = "bg",
            },
        },
    },
}
