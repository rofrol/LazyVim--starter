return {
  -- { "folke/tokyonight.nvim", enabled = false },
  -- { "folke/tokyonight.nvim", opts = { style = "light" } },
  -- { "folke/tokyonight.nvim", opts = { style = "moon" } },
  -- { "folke/tokyonight.nvim", opts = { style = "storm" } },
  -- { "folke/tokyonight.nvim", opts = { style = "night" } },
  { "catppuccin/nvim", enabled = false },
  "https://gitlab.com/protesilaos/tempus-themes-vim",
  "projekt0n/github-nvim-theme",
  {
    "LazyVim/LazyVim",
    opts = {
      -- background = "light",
      colorscheme = "vscode",
      -- colorscheme = "sakura",
      -- colorscheme = "onedark",
      -- colorscheme = "quantum",
    },
  },
  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    config = function()
      local c = require("vscode.colors").get_colors()
      require("vscode").setup({
        -- Alternatively set style in setup
        style = "light",

        -- Enable transparent background
        transparent = true,

        -- Enable italic comment
        italic_comments = false,

        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,

        -- Override colors (see ./lua/vscode/colors.lua)
        color_overrides = {
          -- vscLineNumber = "#FFFFFF",
        },

        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
          -- this supports the same val table as vim.api.nvim_set_hl
          -- use colors from this colorscheme by requiring vscode.colors!
          Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        },
      })
      --require("vscode").load()
    end,
  },
  "numToStr/Sakura.nvim",
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker",
        -- style = "deep",
        toggle_style_key = "<leader>ts",
        diagnostics = {
          darker = false,
          background = false,
        },
      })
    end,
  },
  {
    "mastertinner/nvim-quantum",
    config = function()
      -- require("quantum").setup()
      -- vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = "#ffffff" })
    end,
  },
}
