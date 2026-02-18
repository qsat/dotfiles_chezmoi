return {
	"stevearc/oil.nvim",
	--@module 'oil'
	--@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			lsp_file_methods = { enabled = true },

			columns = {
				"icon",
				"permissions",
				"size",
				"filename",
				-- "mtime",
			},

			keymaps = {
				["<C-l>"] = false,
				["<C-h>"] = false,
				["<C-v>"] = { "actions.select", mode = "n", opts = { vertical = true } },
			},
			view_options = {
				show_hidden = true,
			},
			win_options = {
				--	winbar = "%{v:lua.require('oil').get_current_dir()}",
				winbar = "%#@attribute.builtin#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}",
			},
		})

		vim.api.nvim_create_augroup("OilRelPathFix", {})
		vim.api.nvim_create_autocmd("BufLeave", {
			group = "OilRelPathFix",
			pattern = "oil:///*",
			callback = function()
				vim.cmd("cd .")
			end,
		})
	end,
}
