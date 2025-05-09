vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.api.nvim_set_keymap("t", "<C-n>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-U>", "<C-r>")
vim.keymap.set("n", "<leader>a", "maggVG`a<ESC>", { silent = true })

-- Move selected visual block up and down while maintaining indentation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll half-page up/down while keeping cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Reindent paragraph while preserving cursor position
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Restart LSP
vim.keymap.set("n", "<leader>zig", "<cmd>Lsprestart<cr>")

-- replace selected text without overwriting default register
vim.keymap.set("x", "<leader>p", [["_dp]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Copy (yank) to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- Copy entire line to system clipboard

-- Paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", function()
    vim.cmd('normal! "+p') -- Paste from system clipboard
    vim.cmd("%s/\r//g") -- Remove ^M (\r) characters
end, { silent = true })

vim.keymap.set({ "n", "v" }, "<leader>P", function()
    vim.cmd('normal! "+P') -- Paste before cursor from system clipboard
    vim.cmd("%s/\r//g") -- Remove ^M (\r) characters
end, { silent = true })

-- Delete without copying into the register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Disable 'Q' (default behavior is to enter Ex mode, which is rarely used)
vim.keymap.set("n", "Q", "<nop>")

-- Format buffer with LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix navigation with centering
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace the word under the cursor (global, case-insensitive)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Source (reload) the current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Database (DBee)
vim.keymap.set("n", "<leader>db", "<cmd>Dbee<CR>", { desc = "Open Dbee Database Cliet" })
