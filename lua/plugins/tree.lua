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
                    custom = { 
                        "addon",
                        "__pycache__", 
                        ".git", 
                        ".godot", 
                        ".idea",
                        "*.uid",
                        "*.glb", 
                        "*.png", 
                        "*.jpg", 
                        "*.jpeg", 
                        "*.blend", 
                        "*.blend1", 
                        "*.bin", 
                        "*.gltf",
                        -- Additional common files/folders to ignore:
                        "node_modules",           -- Node.js dependencies
                        ".vscode",                -- VS Code settings
                        ".vs",                    -- Visual Studio files
                        "*.tmp",                  -- Temporary files
                        "*.temp",                 -- Temporary files
                        "*.log",                  -- Log files
                        "*.cache",                -- Cache files
                        ".DS_Store",              -- macOS system files
                        "Thumbs.db",              -- Windows thumbnail cache
                        "*.ico",                  -- Icon files (usually binary)
                        "*.exe",                  -- Executable files
                        "*.dll",                  -- Windows libraries
                        "*.so",                   -- Linux/Unix libraries
                        "*.dylib",                -- macOS libraries
                        "*.o",                    -- Object files
                        "*.obj",                  -- Object files
                        "*.a",                    -- Static libraries
                        "*.lib",                  -- Static libraries
                        "*.pdb",                  -- Program database files
                        "*.ilk",                  -- Incremental linker files
                        "*.meta",                 -- Unity meta files (if you work with Unity)
                        "build",                  -- Common build directory
                        "dist",                   -- Distribution directory
                        "out",                    -- Output directory
                        "target",                 -- Rust/Java target directory
                        ".gradle",                -- Gradle files
                        ".maven",                 -- Maven files
                        "*.zip",                  -- Archive files
                        "*.rar",                  -- Archive files
                        "*.7z",                   -- Archive files
                        "*.tar.gz",               -- Archive files
                        "*.wav",                  -- Audio files
                        "*.mp3",                  -- Audio files
                        "*.ogg",                  -- Audio files
                        "*.mp4",                  -- Video files
                        "*.avi",                  -- Video files
                        "*.mkv",                  -- Video files
                        "*.pdf",                  -- PDF files
                        "*.import",               -- Godot import files
                    },
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
