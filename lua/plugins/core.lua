return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- do I need this?
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        -- https://www.reddit.com/r/neovim/comments/xzhty5/comment/irmgu2m/
        keyword = "fg",
      },
    },
  },
  "ziglang/zig",
  { "echasnovski/mini.pairs", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = { window = {
      position = "right",
    } },
  },
  -- { "folke/tokyonight.nvim", enabled = false },
  -- { "folke/tokyonight.nvim", opts = { style = "light" } },
  -- { "folke/tokyonight.nvim", opts = { style = "moon" } },
  -- { "folke/tokyonight.nvim", opts = { style = "storm" } },
  { "folke/tokyonight.nvim", opts = { style = "night" } },
  { "catppuccin/nvim", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            -- "node_modules",
          },
        },
      },
    },
  },
}
