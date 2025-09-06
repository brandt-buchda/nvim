return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        --priority = 1000,
        config = function()
            local flavor = "mocha"  -- Keep mocha as base for dark theme
            local offset = 12

            -- HSL to RGB hex converter function
            local function hsl_to_hex(h, s, l)
                h = h / 360  -- Convert hue to 0-1 range
                s = s / 100  -- Convert saturation to 0-1 range
                l = (l + offset) / 100  -- Convert lightness to 0-1 range
                
                local function hue_to_rgb(p, q, t)
                    if t < 0 then t = t + 1 end
                    if t > 1 then t = t - 1 end
                    if t < 1/6 then return p + (q - p) * 6 * t end
                    if t < 1/2 then return q end
                    if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
                    return p
                end
                
                local r, g, b
                
                if s == 0 then
                    r, g, b = l, l, l  -- achromatic
                else
                    local q = l < 0.5 and l * (1 + s) or l + s - l * s
                    local p = 2 * l - q
                    r = hue_to_rgb(p, q, h + 1/3)
                    g = hue_to_rgb(p, q, h)
                    b = hue_to_rgb(p, q, h - 1/3)
                end
                
                -- Convert to hex
                r = math.floor(r * 255 + 0.5)
                g = math.floor(g * 255 + 0.5)
                b = math.floor(b * 255 + 0.5)
                
                return string.format("#%02x%02x%02x", r, g, b)
            end
            
            
            require("catppuccin").setup({
                flavor = flavor,
                transparent_background = false,
                show_end_of_buffer = false,
                color_overrides = {
                    mocha = {
                        -- Your preferred grey backgrounds
                        base = "#1F1F1F",
                        mantle = "#1B1B1B",
                        crust = "#161616",
                        
                        -- Bright text colors
                        text = "#E5E8F1",      
                        subtext1 = "#D0D3E1",   
                        subtext0 = "#BBB1CF",   
                        overlay2 = "#86899D",  
                        overlay1 = "#71758B",  
                        overlay0 = "#5C5F79",  
                        
                        -- Colors defined with HSL for easy adjustment
                        rosewater = hsl_to_hex(11, 59, 67),   -- HSL(11°, 59%, 67%)
                        flamingo = hsl_to_hex(0, 60, 67),     -- HSL(0°, 60%, 67%)
                        pink = hsl_to_hex(316, 73, 69),       -- HSL(316°, 73%, 69%)
                        mauve = hsl_to_hex(266, 85, 58),      -- HSL(266°, 85%, 58%)
                        red = hsl_to_hex(347, 87, 44),        -- HSL(347°, 87%, 44%)
                        maroon = hsl_to_hex(355, 76, 59),     -- HSL(355°, 76%, 59%)
                        peach = hsl_to_hex(22, 99, 52),       -- HSL(22°, 99%, 52%)
                        yellow = hsl_to_hex(35, 77, 49),      -- HSL(35°, 77%, 49%)
                        green = hsl_to_hex(109, 58, 40),      -- HSL(109°, 58%, 40%)
                        teal = hsl_to_hex(183, 74, 35),       -- HSL(183°, 74%, 35%)
                        sky = hsl_to_hex(197, 97, 46),        -- HSL(197°, 97%, 46%)
                        sapphire = hsl_to_hex(189, 70, 42),   -- HSL(189°, 70%, 42%)
                        blue = hsl_to_hex(220, 91, 54),       -- HSL(220°, 91%, 54%)
                        lavender = hsl_to_hex(231, 97, 72),   -- HSL(231°, 97%, 72%)
                    },
                },
                integrations = {
                    nvimtree = {
                        enabled = true,
                        transparent_panel = false,
                        show_root = true,
                    },
                },
            })
            vim.cmd("colorscheme catppuccin-" .. flavor)

            local catppuccin = require("catppuccin.palettes").get_palette(flavor)
            vim.api.nvim_set_hl(0, "ColorColumn", { bg = catppuccin.mantle })
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            -- Custom mode mapping function to display full mode names
            local function mode_format(str)
                local modes = {
                    n = "NORMAL",
                    i = "INSERT",
                    v = "VISUAL",
                    V = "V-LINE",
                    [""] = "V-BLOCK", -- visual block mode
                    c = "COMMAND",
                    no = "OP-PENDING",
                    s = "SELECT",
                    S = "S-LINE",
                    [""] = "S-BLOCK",
                    R = "REPLACE",
                    r = "REPLACE",
                    ["!"] = "SHELL",
                }
                return modes[str:sub(1, 1)] or str
            end

            -- Custom mode component for lualine using the formatter
            local custom_mode = {
                "mode",
                fmt = mode_format,
                padding = { left = 1, right = 1 },
            }

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "catppuccin", -- or any theme you prefer
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { custom_mode },
                    lualine_b = { "branch" },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = {},
            })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup({
                rainbow = {
                    enable = true, -- Enable rainbow highlighting
                    extended_mode = true, -- Also highlight non-bracket delimiters if needed
                    max_file_lines = nil, -- Do not disable for large files
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            -- Enable termguicolors for a nicer color palette
            vim.opt.termguicolors = true
            local highlight = {
                "Whitespace",
            }
            require("ibl").setup({
                indent = {
                    highlight = highlight,
                    char = "┊",
                },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false,
                },
                scope = {
                    enabled = true,
                },
            })
        end,
    },
}
