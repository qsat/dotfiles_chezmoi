local options = {
	encoding = "utf-8",
	fileencoding = "utf-8",
	shell = "zsh",
	title = false,
	backup = false,
	autochdir = true,
	autoread = true,
	autoindent = true,
	breakindent = true,
	clipboard = "unnamedplus",
	cmdheight = 0,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	hlsearch = true,
	incsearch = true,
	ignorecase = true,
	-- mouse = "a",
	pumheight = 10,
	showmode = false,
	smartcase = true,
	smartindent = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 300,
	undofile = false,
	updatetime = 300,
	writebackup = false,
	backupskip = { "/tmp/*", "/private/tmp/*" },
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	showtabline = 1,
	softtabstop = 2,
	cursorline = true,
	number = false,
	relativenumber = false,
	numberwidth = 1,
	signcolumn = "yes",
	wrap = true,
	winbar = "",
	winblend = 0,
	wildoptions = "pum",
	pumblend = 5,
	background = "dark",
	scrolloff = 8,
	inccommand = "split",
	sidescrolloff = 8,
	splitbelow = true, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
	splitright = true, -- オのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
	list = true,
	listchars = { tab = "--", trail = "-", nbsp = "+" },
	fillchars = { vert = " " },
}

vim.opt.shortmess:append("c")
vim.g.sidekick_nes = false

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[
  set whichwrap+=<,>,[,],h,l
  set iskeyword+=-
  autocmd QuickFixCmdPost *grep* cwindow
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
  let g:netrw_banner = 0
  let g:netrw_browse_split = 0
  let g:netrw_altv = 1
  let g:netrw_winsize = 25
  " let g:vifm_replace_netrw = 1 
  " let g:vifm_embed_term = 1
]])

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
