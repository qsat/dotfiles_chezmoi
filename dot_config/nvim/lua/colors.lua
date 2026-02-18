vim.cmd([[
  colorscheme iceberg
]])
--  "hi StatusLine term=NONE cterm=NONE ctermfg=238 ctermbg=234 guifg=234 guibg=234
--  hi StatusLine cterm=NONE ctermfg=251 ctermbg=234 guifg=234 guibg=234
--  hi StatusLineNC ctermfg=234 ctermbg=241  guifg=234 guibg=234
--  hi StatusLineTerm term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234
--  hi StatusLineTermNC term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234
--  " tab
--  hi TabLineFill ctermbg=234 ctermfg=234 guibg=NONE guifg=None
--  hi TabLineSel ctermbg=234 ctermfg=251 guibg=NONE guifg=None
--  hi TabLine ctermbg=234 ctermfg=239 guibg=234 guifg=239
--  hi SignColumn ctermbg=234 ctermfg=239 guibg=NONE guifg=None
--
--  hi VertSplit cterm=NONE ctermfg=234 ctermbg=234 guibg=234 guifg=234
--  hi ModeMsg cterm=NONE ctermfg=234 ctermbg=234 guibg=234 guifg=234

local M = {}
local fn = vim.fn

function set(hls)
	for group, value in pairs(hls) do
		vim.api.nvim_set_hl(0, group, value)
	end
end

function link(links)
	for from, to in pairs(links) do
		vim.api.nvim_set_hl(0, from, {
			link = to,
		})
	end
end

local c = { fg = "#888888", bg = "#202020", bg_highlight = "#202020" }

link({
	TabLineSel = "Normal",
	StatusLine = "Normal",
	SnacksDashboardDesc = "Yellow",
	SnacksDashboardDir = "Grey",
	SnacksDashboardFile = "Blue",
	SnacksDashboardHeader = "Blue",
	SnacksDashboardIcon = "Blue",
	SnacksDashboardKey = "Green",
	SnacksDashboardTitle = "RedItalic",
	SnacksPicker = "Normal",
	SnacksPickerBorder = "Grey",
	SnacksPickerTitle = "Title",
	SnacksPickerFooter = "SnacksPickerTitle",
	SnacksPickerTotals = "Grey",
	SnacksPickerSelected = "Blue",
	SnacksPickerInputCursorLine = "Normal",
	SnacksPickerListCursorLine = "CursorLine",
	SnacksPickerToggle = "Yellow",
	SnacksPickerDir = "Comment",
	SnacksPickerBufFlags = "Blue",
	SnacksPickerGitStatus = "Special",
	SnacksPickerKeymapRhs = "Normal",
})
set({
	TabLine = { fg = "#707070", bg = "#202020" },
	TabLineSel = { fg = "#cccccc", bg = "#202020" },
	TabLineFill = { fg = "NONE", bg = "#202020" },

	StatusLine = { fg = "#cccccc", bg = "#202020" },
	StatusLineNC = { fg = "#505050", bg = "#202020" },
	StatusLineFill = { fg = "#707070", bg = "#202020" },

	SignColumn = { fg = "#707070", bg = "#202020" },

	VertSplit = { fg = "#1c1c1c", bg = "#1c1c1c" },
	ModeMsg = { fg = "#1c1c1c", bg = "#1c1c1c" },

	LspFloatWinBorder = { fg = "#202021", bg = "#202021" },
	LspSagaRenameBorder = { fg = "#202021", bg = "#202020" },
	LspSagaHoverBorder = { fg = "#202021", bg = "#202020" },
	LspSagaSignatureHelpBorder = { fg = "#202021", bg = "#202020" },
	LspSagaCodeActionBorder = { fg = "#202021", bg = "#202020" },
	LspSagaDefPreviewBorder = { fg = "#202021", bg = "#202020" },
	LspLinesDiagBorder = { fg = "#202021", bg = "#202020" },
	LspSagaShTruncateLine = { fg = "#202021", bg = "#202020" },
	LspSagaDocTruncateLine = { fg = "#202021", bg = "#202020" },
	LineDiagTuncateLine = { fg = "#202021", bg = "#202020" },
	LspSagaCodeActionTitle = { fg = "#202021", bg = "#202020" },
	LspSagaCodeActionTruncateLine = { fg = "#202021", bg = "#202020" },
	DiagnosticTruncateLine = { fg = "#202021", bg = "#202020" },
	ProviderTruncateLine = { fg = "#202021", bg = "#202020" },

	TelescopeNormal = { bg = c.bg, fg = c.fg },
	TelescopeBorder = { bg = c.bg, fg = c.fg },
	TelescopePromptNormal = { bg = c.bg, fg = c.fg },
	TelescopePromptBorder = { bg = c.bg, fg = c.fg },
	TelescopePromptTitle = { bg = c.bg_highlight, fg = c.fg },
	TelescopePreviewTitle = { bg = c.bg, fg = c.fg },
	TelescopeResultsTitle = { bg = c.bg, fg = c.fg },
	NoiceCmdlinePopupBorder = { bg = c.bg, fg = c.fg },
	NoiceCmdlineIcon = { bg = c.bg, fg = c.fg },
	NoiceCmdlineIconSearch = { bg = c.bg, fg = c.fg },
	NoiceCmdline = { fg = c.fg },
	NoiceCmdlinePopupBorderSearch = { fg = c.fg },
	NoiceConfirmBorder = { fg = c.fg },
	NoiceMini = { fg = c.fg, blend = 0 },
	-- NoiceFormatProgressDone = {
	-- 	bg = O.transparent_background and C.none or U.darken(C.sky, 0.30, C.base),
	-- 	fg = C.subtext0,
	-- },
	-- NoiceFormatProgressTodo = {
	-- 	bg = O.transparent_background and C.none
	-- 		or U.vary_color({ latte = U.lighten(C.mantle, 0.70, C.base) }, U.darken(C.surface0, 0.64, C.base)),
	-- 	fg = C.subtext0,
	-- },
	--
})
