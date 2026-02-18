return {
	"linrongbin16/gitlinker.nvim",
	cmd = "GitLink",
	lazy = true,
	opts = {},
	keys = {
		{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
		{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
	},
	config = function()
		require("gitlinker").setup({
			router = {
				browse = {
					["^ghe%.misosiru%.io"] = require("gitlinker.routers").github_browse,
				},
				blame = {
					["^ghe%.misosiru%.io"] = require("gitlinker.routers").github_blame,
				},
			},
		})
	end,
}
