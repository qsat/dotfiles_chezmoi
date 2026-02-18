local function smart_files()
	local picker = require("snacks").picker
	local root = require("snacks.git").get_root()
	local sources = require("snacks.picker.config.sources")

	local files = root == nil and sources.files
		or vim.tbl_deep_extend("force", sources.git_files, {
			untracked = true,
			-- cwd = vim.uv.cwd(),
		})

	picker({
		multi = { "recent", "buffers", files },
		format = "file",
		matcher = { frecency = true, sort_empty = true },
		filter = { cwd = true },
		transform = "unique_file",
	})
end

return {
	"folke/snacks.nvim",
	---@type table<string, any>
	opts = {
		picker = {
			enable = true,
			prompt = "   ",
			formatters = {
				file = { icon_width = 3 },
			},
			layouts = {
				default = {
					layout = {
						box = "horizontal",
						border = "none",
						width = 0.8,
						min_width = 120,
						height = 0.8,
						{
							box = "vertical",
							border = "none",
							{
								win = "input",
								height = 1,
								border = { " ", " ", " ", " ", " ", " ", " ", " " },
								title = "{title} {live} {flags}",
							},
							{
								win = "list",
								border = { " ", " ", " ", " ", " ", " ", " ", " " },
								-- wo = { signcolumn = "yes:1" }, -- left padding
							},
						},
						{
							win = "preview",
							title = "{preview}",
							border = { " ", " ", " ", " ", " ", " ", " ", " " },
							width = 0.5,
							wo = { number = false },
						},
					},
				},
			},
		},
	},
	keys = {
		{ "<leader><leader>", mode = "n", noremap = true, desc = "Files: Open files", smart_files },
		{ "cj", mode = "n", noremap = true, desc = "LSP: Next diagnostic", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
		{ "ck", mode = "n", noremap = true, desc = "LSP: Prev diagnostic", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
		{ "ge", mode = "n", noremap = true, desc = "LSP: Show diagnostic", "<cmd>lua vim.diagnostic.open_float()<CR>" },
		{ "gD", mode = "n", noremap = true, desc = "LSP: Go declaration", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
		{ "<leader>rn", mode = "n", noremap = true, desc = "LSP: Rename", "<cmd>lua vim.lsp.buf.rename()<CR>" },
		{
			"<leader>ca",
			mode = "n",
			noremap = true,
			desc = "LSP: Code Action",
			"<cmd>lua vim.lsp.buf.code_action()<CR>",
		},
		{
			"gd",
			mode = "n",
			noremap = true,
			desc = "LSP: Go Definition",
			"<cmd>lua require('snacks').picker.lsp_definitions()<CR>",
		},
		{
			"gr",
			mode = "n",
			noremap = true,
			desc = "LSP: Show Reference",
			"<cmd>lua require('snacks').picker.lsp_references()<CR>",
		},
		{
			"<leader>m",
			mode = "n",
			noremap = true,
			desc = "Files: Open files (recent)",
			function()
				-- require("snacks").picker.git_files({ untracked = true })
				require("snacks").picker.recent()
			end,
		},
		{
			"<leader>gs",
			mode = "n",
			noremap = true,
			desc = "Git: Status",
			function()
				require("snacks").picker.git_status()
			end,
		},
		{
			"<leader>gg",
			mode = "n",
			noremap = true,
			desc = "Files: Grep",
			function()
				require("snacks").picker.grep({ hidden = true })
			end,
		},
		{
			"<leader>sd",
			mode = "n",
			noremap = true,
			desc = "Search: Diagnostics",
			function()
				require("snacks").picker.diagnostics()
			end,
		},
		{
			"<leader>sD",
			desc = "Search: Buffer Diagnostics",
			noremap = true,
			function()
				require("snacks").picker.diagnostics()
			end,
		},
	},
}
