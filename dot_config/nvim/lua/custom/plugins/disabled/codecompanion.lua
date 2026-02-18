return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
	keys = {
		{ "<Leader>cc", "<Cmd>CodeCompanionChat Toggle<CR>", mode = { "n" } },
		{ "<Leader>cc", "<Cmd>CodeCompanionChat<CR>", mode = { "v" } },
		{ "<Leader>cx", "<Cmd>CodeCompanionActions<CR>", mode = { "n", "x" } },
	},
	opts = {
		opts = {
			language = "Japanese",
		},
	},
}
