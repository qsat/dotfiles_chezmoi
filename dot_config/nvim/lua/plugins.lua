local lazypath = vim.fn.stdpath("config") .. "/plugins/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

-- https://github.com/yuucu/dotfiles/blob/79adcdebf7bc36b7cb6e14c2bbcf157ebb12a54f/config/nvim/lua/lazyvim.lua#L18-L20

require("lazy").setup({
	spec = { { import = "config.plugins" } },
})
