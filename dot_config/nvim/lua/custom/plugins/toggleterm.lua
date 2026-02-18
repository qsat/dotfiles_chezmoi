return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = true,
	config = function()
		require("toggleterm").setup({
			size = 80,
			open_mapping = [[<c-t>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "vertical",
			close_on_exit = true,
			float_opts = {
				border = "curved",
				winblend = 0,
				width = 80,
				height = 80,
			},
		})
	end,
}
