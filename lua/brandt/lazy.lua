local lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
	{"catppuccin/nvim", name = "catppuccin"},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"mbbill/undotree", name = "undotree"},
	{"tpope/vim-fugitive", lazy = false},
	--{"nvim-tree/nvim-tree.lua", dependencies = {"nvim-tree/nvim-web-devicons"}}
	-- LSP and Tooling
	{ "neovim/nvim-lspconfig" },
  	{ "williamboman/mason.nvim", config = true },
  	{ "williamboman/mason-lspconfig.nvim", config = true },

  	-- Autocompletion plugins
  	{ "hrsh7th/nvim-cmp" },
  	{ "hrsh7th/cmp-nvim-lsp" },
 	{ "L3MON4D3/LuaSnip" },
  	{ "saadparwaiz1/cmp_luasnip" },
  })
