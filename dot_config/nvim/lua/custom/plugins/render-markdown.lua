return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		heading = {
			-- 見出しの左側に表示される記号（#）の扱い
			-- 'overlay' は # をアイコンで隠し、'inline' は # をそのまま表示
			position = "overlay",
			-- 見出しの各レベルに使うアイコン（お好みで変更可能）
			icons = { "h1. ", "h2. ", "h3. ", "h4. ", "h5. ", "h6. " },
			width = "block",
			left_pad = 0,
			right_pad = 4,
			-- 背景色は消すが、文字の色（Foreground）を維持するための設定
			foregrounds = {
				"RenderMarkdownH1",
				"RenderMarkdownH2",
				"RenderMarkdownH3",
				"RenderMarkdownH4",
				"RenderMarkdownH5",
				"RenderMarkdownH6",
			},
		},
	},
}
