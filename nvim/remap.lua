vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q!<CR>")
-- make current file executable
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>")
vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>", { noremap = true, silent = true })

vim.cmd [[
  " Jumplist mutations
  nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
  nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
]]

-- Undo break points
vim.keymap.set('i', ',', ',<c-g>u', { noremap = true, silent = true })
vim.keymap.set('i', '.', '.<c-g>u', { noremap = true, silent = true })
vim.keymap.set('i', '!', '!<c-g>u', { noremap = true, silent = true })
vim.keymap.set('i', '?', '?<c-g>u', { noremap = true, silent = true })

vim.keymap.set("n", 'Q', '<nop>')

vim.keymap.set("v", 'p', '"_dP')

-- Move lines up / down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeping it centered
vim.keymap.set("n", 'n', 'nzzzv')
vim.keymap.set("n", 'N', 'Nzzzv')
vim.keymap.set("n", 'J', 'mzJ`z')
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Easier movement between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Clear search highlights on Esc
vim.keymap.set("n", '<Esc>', ':noh <CR>')
vim.keymap.set("i", '<Esc>', '<Esc> :noh <CR>')

vim.keymap.set("n", "<leader>wt", "<C-6>")
vim.keymap.set("n", "<leader>ww", "<cmd>:bd<CR>")
vim.keymap.set("n", "<leader>wa", "<cmd>:BufferlineCloseOthers<CR>")
vim.keymap.set("n", "<leader>b", ":b ")

-- Maintain the cursor position when yanking a visual selection
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>gp", "<cmd>NvimTreeFindFile<CR>")

-- Delete into black hole register per default
vim.keymap.set("n", "d", "\"_d")
vim.keymap.set("n", "dd", "\"_dd")
vim.keymap.set("n", "D", "\"_D")
vim.keymap.set("n", "c", "\"_c")
vim.keymap.set("n", "cc", "\"_cc")
vim.keymap.set("n", "C", "\"_C")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "X", "\"_X")
-- and use s key to cut instead
vim.keymap.set("n", "s", "d")
vim.keymap.set("v", "s", "d")
vim.keymap.set("n", "ss", "dd")
vim.keymap.set("n", "S", "D")

vim.keymap.set("n", "<leader><leader>x", "<cmd>silent :w<CR><BAR><cmd>source %<CR>")
