return {
	"christoomey/vim-tmux-navigator",
	event = "VimEnter",
	-- cmd = {
	-- 	"TmuxNavigateLeft",
	-- 	"TmuxNavigateDown",
	-- 	"TmuxNavigateUp",
	-- 	"TmuxNavigateRight",
	-- 	"TmuxNavigatePrevious",
	-- },
	config = function()
		vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<c-\\>", ":TmuxNavigatePrevious<cr>", { noremap = true, silent = true })
	end,
}
