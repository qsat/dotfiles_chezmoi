vim.g.have_nerd_font = true

require("option")
require("colors")
require("keymaps")
require("statusline")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- { "nvim-java/nvim-java", ft = "java" },
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({
									group = "kickstart-lsp-highlight",
									buffer = event2.buf,
								})
							end,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- 1. tsgo のカスタム定義 (lspconfig本体をロードせずに注入)
			-- これを最初に行うことで、後の setup が tsgo を認識できるようになります
			local lsp_configs = require("lspconfig.configs")
			if not lsp_configs.tsgo then
				lsp_configs.tsgo = {
					default_config = {
						cmd = { "tsgo", "lsp" },
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
						single_file_support = true,
					},
				}
			end

			local servers = {
				tsgo = {},
				lua_ls = {
					settings = { Lua = { completion = { callSnippet = "Replace" } } },
				},
				eslint = {},
			}

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "eslint" },
			})

			-- 2. 各サーバーをセットアップ
			-- 警告を回避するため、require("lspconfig") という変数に代入せず、
			-- 直接インデックスアクセスして setup を呼びます。
			for server_name, server_config in pairs(servers) do
				server_config.capabilities = capabilities -- 共通の capabilities

				-- ここが重要：[server_name] へのアクセスで setup を実行
				require("lspconfig")[server_name].setup(server_config)
			end
		end,
	},

	-- require("kickstart.plugins.debug"),
	require("kickstart.plugins.lint"),

	{ import = "custom.plugins" },
})

-- vim: ts=2 sts=2 sw=2 et
