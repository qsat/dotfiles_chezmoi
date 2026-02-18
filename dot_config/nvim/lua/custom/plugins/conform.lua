return { -- Autoformat
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 2000,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			yaml = { "yamlfmt" },
			xml = { "xmlformatter" },
			html = { "prettierd" },
			json = { "prettierd" },
			javascript = { "eslint_d", "prettierd", stop_after_first = false },
			typescript = { "eslint_d", "prettierd", stop_after_first = false },
			javascriptreact = { "eslint_d", "prettierd", stop_after_first = false },
			typescriptreact = { "eslint_d", "prettierd", stop_after_first = false },
		},
	},
}
