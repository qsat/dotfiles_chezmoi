return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		require("telescope").setup({
			-- pickers = {}
			defaults = {
				find_command = { "fd", "-t=f", "-a" },
				path_display = { "relative" },
				wrap_results = true,
				layout_strategy = "horizontal",
				borderchars = { "", "", "", "", "", "", "", "" },
				-- layout_config = { vertical = { width = 0.99, height = 0.99, opacity = 0.98 } },
				mappings = {
					i = {
						-- https://medium.com/@shaikzahid0713/telescope-333594836896
						["<esc>"] = require("telescope.actions").close,
						["<C-u>"] = false,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
				winblend = 20,
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		--vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		-- vim.keymap.set("n", "<leader>p", builtin.git_files, { desc = "Search Git Files" })

		-- vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
		-- vim.keymap.set("n", "cj", "<cmd>lua vim.diagnostic.goto_next()<CR>")
		-- vim.keymap.set("n", "ck", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

		-- vim.keymap.set("n", "<leader><leader>", function()
		-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		-- 		winblend = 10,
		-- 		previewer = false,
		-- 	}))
		-- end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- vim.keymap.set("n", "<leader>sn", function()
		-- 	builtin.find_files({ cwd = vim.fn.stdpath("config"), previewer = false, shorten_path = true })
		-- end, { desc = "[S]earch [N]eovim files" })
		-- vim.keymap.set("n", "<leader>m", function()
		-- 	builtin.oldfiles({ previewer = false, shorten_path = true })
		-- end, { desc = '[S]earch Recent Files ("." for repeat)' })
		-- vim.keymap.set("n", "<leader>p", function()
		-- 	builtin.git_files({ previewer = false, shorten_path = true })
		-- end, { desc = "Search Git Files" })

		local map = function(keys, func, desc)
			-- vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gb", require("telescope.builtin").git_bcommits, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		-- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	end,
}
