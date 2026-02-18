return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signcolumn = true,
			numhl = true,
			linehl = false,
			current_line_blame = true,
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "stage_hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "reset_hunk" })
				map("n", "<leader>hj", gitsigns.next_hunk, { desc = "next_hunk" })
				map("n", "<leader>hk", gitsigns.prev_hunk, { desc = "prev_hunk" })
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage_line" })
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset_stage_line" })
				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "stage buffer" })
				map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "undo stage hunk" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "rest buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview hunk" })
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "blame line" })
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
				map("n", "<leader>hd", gitsigns.diffthis, { desc = "diff this" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "diff this" })
				map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "toggle_deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select_hunk" })
			end,
		})
	end,
}
