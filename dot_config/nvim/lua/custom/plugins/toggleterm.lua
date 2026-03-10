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
			on_open = function(term)
				-- ターミナルが開いた時に左端へ移動させる
				vim.cmd("wincmd H")
				vim.defer_fn(function()
					local win_id = term.window
					if vim.api.nvim_win_is_valid(win_id) then
						vim.api.nvim_win_set_width(win_id, 80) -- ここで確実に幅を40にする
						vim.api.nvim_win_set_option(win_id, "winfixwidth", true)
					end
				end, 10) -- 10ミリ秒待つ
			end,
		})
	end,
}
