local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- let mapleader = "\<Space>"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- " 縦分割版gf
-- nnoremap gs :vertical wincmd f<CR>
-- nnoremap gn <C-w>gf
-- noremap <Leader>Q :cprevious<CR>
-- noremap <Leader>q :cnext<CR>
-- noremap <Leader>L :lp<CR>
-- noremap <Leader>l :lne<CR>
-- noremap <Leader>z <C-w>T<CR>
-- noremap j gj
-- noremap gl gt
-- noremap gh gT
-- noremap tn :tabnew<CR>
-- noremap k gk
-- noremap 0 g0
-- tnoremap <silent> <ESC> <C-\><C-n>

keymap("n", "gs", ":vertical wincmd f<CR>", opts)
keymap("n", "gn", "<C-w>gf", opts)
keymap("n", "<C-h>", "<C-w>W", opts)
keymap("n", "<C-l>", "<C-w>w", opts)
keymap("t", "<C-h>", [[<C-\><C-n><C-w>W]], term_opts)
keymap("t", "<C-l>", [[<C-\><C-n><C-w>w]], term_opts)
keymap("n", "<Leader>z", "<C-w>T", opts)
keymap("n", "j", "gj", opts)
keymap("n", "gl", "gt", opts)
keymap("n", "gh", "gT", opts)
keymap("n", "tn", ":tabnew .<CR>", opts)
keymap("n", "k", "gk", opts)
keymap("n", "0", "g0", opts)
keymap("n", "<Leader>q", ":cnext<CR>", opts)
keymap("n", "<Leader>Q", ":cprevious<CR>", opts)
keymap("n", "<Leader>l", ":lne<CR>", opts)
keymap("n", "<Leader>L", ":lp<CR>", opts)
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)
keymap("n", "<Leader>e", ":vs <bar> Oil .<CR>", opts)
keymap("n", "<Leader>dd", ":DiffviewOpen<CR>", opts)
keymap("n", "<Leader>dc", ":DiffviewClose<CR>", opts)
keymap("n", "<Leader>gp", ":let @+ = system('git rev-parse --show-prefix')[:-2] . expand('%:t')<CR>", opts)

-- cnoreabbrev Ack Ack!
-- nnoremap <Leader>a :Gcd <bar> Ack!<Space>
keymap("n", "<Leader>a", ":Gcd <bar> Ack!<Space>", { noremap = true })

-- nmap <ESC><ESC> :nohlsearch<CR>
keymap("n", "<ESC><ESC>", ":nohlsearch", opts)
-- inoremap jk <ESC>
keymap("i", "jj", "<ESC>", opts)

-- Open diagnostic [Q]uickfix list
vim.keymap.set("n", "<leader>sq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
