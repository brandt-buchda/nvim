return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            -- Option A: Terminal always opens where nvim was launched.
            local start_dir = vim.fn.getcwd()

            require("toggleterm").setup({
                size = 10,
                open_mapping = [[<c-\>]],
                direction = "float",
            })
        end,
    },
}
