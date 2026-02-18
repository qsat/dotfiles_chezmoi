return {
	"kylechui/nvim-surround",
	version = "*",
	event = "ModeChanged",
	config = function()
		require("nvim-surround").setup({})
	end,
}
