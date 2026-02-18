return {
	"stevearc/aerial.nvim",
	lazy = true,
	cmd = { "AerialToggle", "AerialOpen", "AerialClose", "AerialInfo" },
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("aerial").setup({
			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set("n", "<leader>{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "<leader>}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		})
		-- You probably also want to set a keymap to toggle aerial
		vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>")
	end,
}
