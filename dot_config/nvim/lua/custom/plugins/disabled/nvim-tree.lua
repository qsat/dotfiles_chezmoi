return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeOpen", "NvimTreeToggle" },
  dependencies = {
    -- "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local keymap = vim.api.nvim_set_keymap
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      vim.keymap.set("n", "d", api.fs.trash, opts("Help"))
    end
    local opt = { noremap = true, silent = true }
    -- keymap("n", "<Leader>g", ":Gcd! <Cr>", opt)
    keymap("n", "<Leader>e", ":Gcd <bar> NvimTreeOpen <bar> NvimTreeFindFile <bar> Gcd! <Cr>", opt)
    keymap("n", "<Leader>c", ":Gcd <bar> NvimTreeCollapseKeepBuffers<Cr>", opt)
    require("nvim-tree").setup({
      sort_by = "extension",
      update_focused_file = {
        enable = true,
        update_cwd = false,
        update_root = {
          enable = true,
        },
      },
      view = {
        width = "24%",
        side = "left",
        signcolumn = "no",
      },
      hijack_netrw = false,
      respect_buf_cwd = false,
      prefer_startup_root = true,
      sync_root_with_cwd = true,
      root_dirs = { ".git", ".vscode", ".vim", "package.json" },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "name",
        icons = {
          glyphs = {
            default = "",
            symlink = "s",
            bookmark = "b",
            modified = "●",
            folder = {
              arrow_closed = "=",
              arrow_open = "-",
              default = "",
              open = "",
              empty = "e",
              empty_open = "e",
              symlink = "s",
              symlink_open = "s",
            },
            git = {
              unstaged = "!",
              renamed = "»",
              untracked = "?",
              deleted = "x",
              staged = "+",
              unmerged = "m",
              ignored = "◌",
            },
          },
        },
      },

      git = {
        enable = true,
        ignore = false,
      },

      actions = {
        expand_all = {
          max_folder_discovery = 100,
          exclude = { ".git", "target", "build" },
        },
        open_file = {
          window_picker = {
            chars = "HLJK1234567890",
          },
        },
      },
      trash = {
        cmd = "trash",
      },
      on_attach = my_on_attach,
    })
    vim.g.nvim_tree_bindings = {
      { key = "d", cb = ":lua NvimTreeTrash()<CR>" },
    }
  end,
}
