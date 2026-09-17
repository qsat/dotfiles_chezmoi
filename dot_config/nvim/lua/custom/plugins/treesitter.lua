-- nvim-treesitter は main ブランチ。旧 master の `ensure_installed` / `highlight` /
-- `auto_install` を opts に渡しても黙って無視されるため、main の作法で書く。
--   - パーサは require("nvim-treesitter").install(...) で入れる
--   - ハイライトは FileType で vim.treesitter.start() を自分で呼ぶ
--   - インデントは indentexpr を自分で設定する
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup({})

		-- Lean は nvim-treesitter 本体に同梱されていないので、文法とクエリを直接登録する。
		-- queries はこのリポジトリの queries/ をそのまま使う。
		-- install/update は内部で parsers モジュールを読み直すため、その直後に発火する
		-- User TSUpdate でも登録し直さないと、この定義が消えてしまう。
		local function register_lean()
			require("nvim-treesitter.parsers").lean = {
				install_info = {
					url = "https://github.com/Julian/tree-sitter-lean",
					revision = "259a2daf7a699cc047221f1e043e4d045fcd6be2",
					queries = "queries",
				},
				tier = 3,
			}
		end
		register_lean()
		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			group = vim.api.nvim_create_augroup("custom-treesitter-parsers", { clear = true }),
			callback = register_lean,
		})

		local ensure_installed = {
			"bash",
			"c",
			"css",
			"diff",
			"html",
			"java",
			"javascript",
			"json",
			"lean",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"pug",
			"query",
			"scss",
			"sql",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		}
		-- 未インストールのものだけ入れる（起動のたびに走らせない）
		local missing = vim.tbl_filter(function(lang)
			return not vim.tbl_contains(ts.get_installed(), lang)
		end, ensure_installed)
		if #missing > 0 then
			ts.install(missing)
		end

		-- ruby だけは treesitter のインデントが壊れがちなので従来どおり除外し、
		-- 正規表現ベースの syntax も併用する。
		local no_ts_indent = { ruby = true }
		local also_vim_syntax = { ruby = true }

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true }),
			callback = function(ev)
				local ft = vim.bo[ev.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return
				end
				-- パーサ未インストールなら何もしない（従来の syntax にそのまま任せる）
				if not pcall(vim.treesitter.start, ev.buf, lang) then
					return
				end
				if also_vim_syntax[ft] then
					vim.bo[ev.buf].syntax = "on"
				end
				if not no_ts_indent[ft] then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
