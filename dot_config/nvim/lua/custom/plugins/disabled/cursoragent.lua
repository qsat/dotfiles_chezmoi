return {
	"aug6th/cursoragent.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("cursoragent").setup({
			terminal = {
				split_side = "left",
			},
		})
		vim.keymap.set("n", "<C-p>", ":CursorAgent<CR>", { desc = "Cursor Agent: Toggle terminal" })
		vim.keymap.set("t", "<C-p>", [[<C-\><C-n>:CursorAgent<CR>]], { desc = "Cursor Agent: Toggle terminal" })
		vim.keymap.set("v", "<C-p>", ":CursorAgentSelection<CR>", { desc = "Cursor Agent: Send selection" })
		vim.keymap.set("n", "<leader><C-p>", ":CursorAgentAsk<CR>", { desc = "Cursor Agent: Send buffer" })
	end,
}
