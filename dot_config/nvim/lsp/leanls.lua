-- Lean の LSP（構文・型エラーの診断のみ）。
-- ハイライトは custom/plugins/treesitter.lua が担当しているので、ここでは触れない。
--
-- Neovim 0.11+ は runtimepath の `lsp/<name>.lua` をサーバー定義として読む。
-- init.lua で `leanls` を enable すると、この表がその定義になる。
-- プラグインの spec（lua/custom/plugins/）としては書かないこと。
-- nvim-lspconfig の spec を二重に宣言すると lazy.nvim がマージして、
-- init.lua 側の LSP セットアップを丸ごと上書きしてしまう。

---@type vim.lsp.Config
return {
	-- Lean のツールチェイン（elan 経由）に同梱されているサーバーを、
	-- そのプロジェクトの lakefile 経由で起動する。追加のインストールは不要。
	cmd = { "lake", "serve", "--" },
	filetypes = { "lean" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.root(fname, { "lakefile.toml", "lakefile.lean", "lean-toolchain" })
		on_dir(root or vim.fs.dirname(fname))
	end,
}
