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
      -- colorscheme = "visual_studio_code",
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
        toggle_style_key = "<leader>uo",
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
  -- {
  --   "askfiy/visual_studio_code",
  --   -- priority = 100,
  --   config = function()
  --     require("visual_studio_code").setup({
  --       -- `dark` or `light`
  --       mode = "light",
  --     })
  --     -- vim.cmd([[colorscheme visual_studio_code]])
  --
  --     require("lualine").setup({
  --       options = {
  --         theme = "visual_studio_code",
  --         -- theme = "vscode",
  --         icons_enabled = true,
  --         component_separators = { left = "", right = "" },
  --         section_separators = { left = "", right = "" },
  --         disabled_filetypes = {},
  --         globalstatus = true,
  --         refresh = {
  --           statusline = 100,
  --         },
  --       },
  --       sections = require("visual_studio_code").get_lualine_sections(),
  --     })
  --   end,
  -- },
}
