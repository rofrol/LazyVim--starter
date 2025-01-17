return {
  {
    "LazyVim/LazyVim",
    opts = {
      background = "light",
      -- colorscheme = "vscode",
      -- colorscheme = "github_light",
      colorscheme = "catppuccin",
      -- colorscheme = "dayfox",

      -- colorscheme = "antiphoton",
      -- colorscheme = "lumiere",

      -- colorscheme = "off",
      -- background = "light",

      -- colorscheme = "plain",
      -- background = "light",

      -- colorscheme = "paramount",
      -- background = "light",

      -- colorscheme = "onedark",

      -- colorscheme = "modus",

      -- colorscheme = "deepwhite",

      -- colorscheme = "ivory",

      -- colorscheme = "nano-theme",

      -- colorscheme = "accent",

      -- colorscheme = "fogbell_light",

      -- colorscheme = "mies",


      -- colorscheme = "nofrils-light",

      -- colorscheme = "visual_studio_code",
      -- colorscheme = "sakura",
      -- colorscheme = "onedark",
      -- colorscheme = "quantum",
    },
  },
  -- { "folke/tokyonight.nvim", enabled = false },
  -- { "folke/tokyonight.nvim", opts = { style = "light" } },
  -- { "folke/tokyonight.nvim", opts = { style = "moon" } },
  -- { "folke/tokyonight.nvim", opts = { style = "storm" } },
  -- { "folke/tokyonight.nvim", opts = { style = "night" } },
  -- { "catppuccin/nvim", enabled = false },
  -- https://www.reddit.com/r/neovim/comments/1bukmz6/comment/kxzjzp6/
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true, -- disables dimming on inactive pane
      color_overrides = {
        all = {
          text = "#000000",
        },
        -- https://github.com/WilliamHsieh/catppuccin.nvim/blob/main/lua/catppuccin/palettes/latte.lua
        -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-8105066
        latte = {
          rosewater = "#cc7983",
          flamingo = "#bb5d60",
          pink = "#d54597",
          mauve = "#a65fd5",
          red = "#b7242f",
          maroon = "#db3e68",
          peach = "#e46f2a",
          yellow = "#bc8705",
          green = "#1a8e32",
          teal = "#00a390",
          sky = "#089ec0",
          sapphire = "#0ea0a0",
          blue = "#017bca",
          lavender = "#8584f7",
          -- subtext1 = "#555555",
          -- subtext0 = "#666666",
          -- overlay2 = "#777777",
          -- overlay1 = "#888888",
          -- overlay0 = "#999999",
          -- surface2 = "#aaaaaa",
          -- surface1 = "#bbbbbb",
          surface1 = "#eeeeee", -- lighter background color for active item in https://github.com/jesseduffield/lazygit
          -- surface0 = "#cccccc",

          -- base and mantle are use to set background color for active item in telescope
          base = "#000000",
          mantle = "#ffffff",
          crust = "#dddddd",
        },
      }
    },
  },
  { "EdenEast/nightfox.nvim",
    -- opts = {
    --   options={
    --     transparent = true,     -- Disable setting background
    --     terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    --     dim_inactive = true,
    --   },
    -- },
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,     -- Disable setting background
          terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,
          palettes = {
            dayfox = {
              bg1 = "#ffffff",
            },
          },
        },
      })
    end,
  },
  "https://gitlab.com/protesilaos/tempus-themes-vim",
  "projekt0n/github-nvim-theme",
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
  'alexanderjeurissen/lumiere.vim',
  {
    'pbrisbin/vim-colors-off',
    config = function()
      -- require("quantum").setup()
      -- vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = "#ffffff" })
    end,
  },
  'andreypopp/vim-colors-plain',
  'owickstrom/vim-colors-paramount',
  {
    "shaunsingh/nord.nvim",
    config = function()
      local hl_groups = vim.api.nvim_get_hl(0, {})

      -- disable italic font
      for key, hl_group in pairs(hl_groups) do
        if hl_group.italic then
          vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, { italic = false }))
        end
      end
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    config = function()
      require("modus-themes").setup({
        style = "modus_operandi", -- Always use modus_operandi regardless of `vim.o.background`
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          functions = { italic = false },
          variables = { italic = false },
        },

        on_colors = function(colors)
          colors.error = colors.red_faint -- Change error color to the "faint" variant
        end,
        on_highlights = function(highlight, color)
          highlight.Boolean = { fg = color.green } -- Change Boolean highlight to use the green color
        end,
      })
    end,
  },
  'Verf/deepwhite.nvim',
  {
    -- Colorscheme
    "mstcl/ivory",
    lazy = false,
    priority = 1000,
    dependencies = {
      "rktjmp/lush.nvim",
    },
    config = function()
      -- vim.cmd.colorscheme("ivory_extended")
    end,
  },
  {
    "ronisbr/nano-theme.nvim",
    init = function ()
      vim.o.background = "light" -- or "dark".
    end
  },
  {
    'alligator/accent.vim',
    config = function()
      vim.g.accent_colour="blue"
      vim.g.accent_darken = 1
      vim.g.accent_no_bg=1
    end
  },
  'jaredgorski/fogbell.vim',
  'jaredgorski/Mies.vim',
  'robertmeta/nofrils',
  'rofrol/photon.vim',
}
