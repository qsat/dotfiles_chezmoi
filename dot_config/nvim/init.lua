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

			-- config = function() ... の中身
			local mason_lspconfig = require("mason-lspconfig")
			-- 直接 require("lspconfig") せず、必要なモジュールだけ取得する
			local lspconfig_util = require("lspconfig.util")

			-- 1. tsgo のカスタム定義 (lspconfig に未定義の場合のみ)
			-- ここで require("lspconfig").configs を使うと警告が出るため、内部モジュールを直接叩く
			local configs = require("lspconfig.configs")
			if not configs.tsgo then
				configs.tsgo = {
					default_config = {
						cmd = { "tsgo", "lsp" },
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						root_dir = lspconfig_util.root_pattern("package.json", "tsconfig.json", ".git"),
						single_file_support = true,
					},
				}
			end

			local servers = {
				tsgo = {},
				lua_ls = {
					settings = { Lua = { completion = { callSnippet = "Replace" } } },
				},
				eslint = {
					settings = {
						codeAction = {
							disableRuleComment = { enable = true, location = "separateLine" },
							showDocumentation = { enable = true },
						},
					},
				},
			}

			require("mason").setup()

			-- 2. Mason 管理下のサーバーをセットアップ
			mason_lspconfig.setup({
				handlers = {
					function(server_name)
						-- tsgo は Mason にないのでここでは無視
						if server_name == "tsgo" then
							return
						end

						local server_config = servers[server_name] or {}
						server_config.capabilities = capabilities
						-- 警告を避けるため、require("lspconfig")[name] 形式で呼び出す
						require("lspconfig")[server_name].setup(server_config)
					end,
				},
			})

			-- 3. tsgo を個別にセットアップ (Mason を通さない)
			require("lspconfig").tsgo.setup(servers.tsgo)
		end,
	},

	-- require("kickstart.plugins.debug"),
	require("kickstart.plugins.lint"),

	{ import = "custom.plugins" },
})

-- vim: ts=2 sts=2 sw=2 et
