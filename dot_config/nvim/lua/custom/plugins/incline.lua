return {
	"b0o/incline.nvim",
	config = function()
		local devicons = require("nvim-web-devicons")
		require("incline").setup({
			window = {
				padding = 2,
				placement = { vertical = "top" },
			},
			render = function(props)
				local fpath = vim.api.nvim_buf_get_name(props.buf)
				local filename = vim.fn.fnamemodify(fpath, ":t")
				if filename == "" then
					filename = "*"
				end

				local ft_icon, ft_color = devicons.get_icon_color(filename)

				local t = vim.split(fpath, "/")
				local tt = {}
				if #t > 3 then
					table.move(t, #t - 3, #t, 1, tt)
				end
				local filepath = table.concat(tt, "/")

				local cursor = vim.api.nvim_win_get_cursor(props.win)
				local line = cursor[1]
				local col = cursor[2] + 1 -- 列は0から始まるため+1

				local function get_git_diff()
					local icons = { removed = " ", changed = " ", added = " " }
					local signs = vim.b[props.buf].gitsigns_status_dict
					local labels = {}
					if signs == nil then
						return labels
					end
					for name, icon in pairs(icons) do
						if tonumber(signs[name]) and signs[name] > 0 then
							table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
						end
					end
					if #labels > 0 then
						table.insert(labels, { "┊ " })
					end
					return labels
				end

				local function get_diagnostic_label()
					local icons = { error = " ", warn = " ", info = " ", hint = "？" }
					local label = {}

					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
						end
					end
					if #label > 0 then
						table.insert(label, { "┊ " })
					end
					return label
				end

				return {
					{ line .. " ┊ " },
					{ get_diagnostic_label() },
					{ get_git_diff() },
					{ (ft_icon or "") .. "  ", guifg = ft_color, guibg = "none" },
					{
						-- filepath .. " ",
						filename .. " ",
						gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
					},
					--{ "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
				}
			end,
		})
	end,
	-- Optional: Lazy load Incline
	event = "VeryLazy",
}
