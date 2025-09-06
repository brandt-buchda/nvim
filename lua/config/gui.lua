-- GUI-specific settings
vim.opt.guifont = "JetBrainsMono Nerd Font:h12"

-- Disable all cursor animations
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_unfocused_outline_width = 0

-- Optional: Other Neovide settings you might want
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_transparency = 1.0
vim.g.neovide_scroll_animation_length = 0  -- Also disable scroll animations
vim.g.neovide_position_animation_length = 0  -- Disable window position animations
vim.g.neovide_floating_blur_amount_x = 0.0
vim.g.neovide_floating_blur_amount_y = 0.0

-- Keep refresh rate high for smooth experience
vim.g.neovide_refresh_rate = 120
vim.g.neovide_refresh_rate_idle = 5
