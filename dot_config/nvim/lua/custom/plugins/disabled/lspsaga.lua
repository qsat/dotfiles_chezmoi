  return {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          border = "none",
          title = false,
          devicon = false,
          foldericon = false,
          lines = { " ", " ", " ", " ", " " },
          button = { "-", "+" },
          imp_sign = "! ",
          expand = "+",
          collapse = "-",
          use_nerd = false,
        },
        lightbulb = {
          enable = false,
        },
        code_action = {
          num_shortcut = false,
          keys = {
            quit = "<C-c>",
          },
        },
        finder = {
          keys = {
            quit = "<C-c>",
          },
        },
        callhierarchy = {
          keys = {
            quit = "<C-c>",
          },
        },
        definition = {
          keys = {
            quit = "<C-c>",
          },
        },
        outline = {
          layout = "float",
          keys = {
            quit = "<C-c>",
          },
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
    },
  }
