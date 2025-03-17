vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Ensure the plugin is loaded
local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvim_tree.setup({
  view = {
    width = 30, -- Adjust width of file tree
    side = "left", -- Positioning of file tree
  },
  renderer = {
    icons = {
      glyphs = {
        default = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
        },
      },
    },
  },
  filters = {
    dotfiles = false, -- Hide dotfiles (set to true if needed)
  },
  git = {
    enable = true,
    ignore = false, -- Show ignored git files
  },
})

-- Optional Keybinding to Toggle File Tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
