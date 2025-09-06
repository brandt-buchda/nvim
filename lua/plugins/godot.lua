return {
    -- Godot syntax highlighting and file detection
    {
        "habamax/vim-godot",
        ft = { "gdscript", "gd", "godot" }, -- Only load when editing these file types
        config = function()
            -- Set up file type detection for Godot files
            vim.filetype.add({
                extension = {
                    gd = "gdscript",
                    tscn = "godot",
                    tres = "godot",
                },
                filename = {
                    ["project.godot"] = "godot",
                },
            })
        end,
    },
}