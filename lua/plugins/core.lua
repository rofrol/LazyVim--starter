return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     -- do I need this?
  --     vim.list_extend(opts.ensure_installed, {
  --       "tsx",
  --       "typescript",
  --     })
  --   end,
  -- },
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
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        shade_terminals = false,
        -- add --login so ~/.zprofile is loaded
        -- https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile/16021#16021
        shell = "zsh --login",
      })
    end,
    keys = {
      -- https://github.com/LazyVim/LazyVim/discussions/193#discussioncomment-5988621
      { [[<C-\>]] },
      { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
      {
        "<leader>td",
        "<cmd>ToggleTerm size=40 dir=~/Desktop direction=horizontal<cr>",
        desc = "Open a horizontal terminal at the Desktop directory",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },
}
