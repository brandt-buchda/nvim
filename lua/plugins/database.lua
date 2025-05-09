return {
    {
        "kndndrj/nvim-dbee",
        dependencies = { "MunifTanjim/nui.nvim" },
        build = function()
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup({
                sources = {
                    require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
                },
                -- You can add other config options here like keymaps, UI prefs, etc.
            })
        end,
        event = "VeryLazy",
    },
}
