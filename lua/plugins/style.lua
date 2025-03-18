return {
	{
	    "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                color_overrides = {
		            mocha = {
            		    base   = "#1F1F1F",
            		    mantle = "#1B1B1B",
            		    crust  = "#161616",
        	        }
	            },
                flavor = "mocha",
                transparent_background = false,
                show_end_of_buffer = false,
            })
            vim.cmd("colorscheme catppuccin")
        end,
	},
    {
        "nvim-tree/nvim-web-devicons"
    },

{
  "nvim-lualine/lualine.nvim",
  config = function()
    -- Custom mode mapping function to display full mode names
    local function mode_format(str)
      local modes = {
        n   = "NORMAL",
        i   = "INSERT",
        v   = "VISUAL",
        V   = "V-LINE",
        [''] = "V-BLOCK", -- visual block mode
        c   = "COMMAND",
        no  = "OP-PENDING",
        s   = "SELECT",
        S   = "S-LINE",
        [''] = "S-BLOCK",
        R   = "REPLACE",
        r   = "REPLACE",
        ["!"] = "SHELL",
      }
      return modes[str:sub(1,1)] or str
    end

    -- Custom mode component for lualine using the formatter
    local custom_mode = {
      'mode',
      fmt = mode_format,
      padding = { left = 1, right = 1 },
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "catppuccin",  -- or any theme you prefer
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
        lualine_z = {}
      },
      extensions = {}
    })
  end,
    },
}
