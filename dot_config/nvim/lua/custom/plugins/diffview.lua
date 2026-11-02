return {
	"sindrets/diffview.nvim",
	-- lazy = true,
	-- events = { "BufReadPre", "BufNewFile" },
	-- cmd = { "DiffViewOpen", "DiffViewClose", "DiffViewToggleFiles", "DiffViewFocusFiles", "DiffViewRefresh" },
	config = function()
		require("diffview").setup({})

		-- Diffview のタブで :q（ZZ・:wq・<C-w>q も同じ）を実行したら、残りの差分とファイル一覧も含めて Diffview ごと閉じる
		vim.api.nvim_create_autocmd("QuitPre", {
			group = vim.api.nvim_create_augroup("diffview-close-whole-view", { clear = true }),
			callback = function()
				local tab = vim.api.nvim_get_current_tabpage()
				if not require("diffview.lib").tabpage_to_view(tab) then
					return
				end
				vim.schedule(function()
					if not vim.api.nvim_tabpage_is_valid(tab) or not require("diffview.lib").tabpage_to_view(tab) then
						return
					end
					vim.api.nvim_set_current_tabpage(tab)
					vim.cmd("DiffviewClose")
				end)
			end,
		})
	end,
}
