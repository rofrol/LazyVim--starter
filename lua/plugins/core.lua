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
    "rcarriga/nvim-notify",
    -- https://github.com/evertonlopesc/nvim/blob/6480813d7cbe08fbf915164ad4d247075ccf41e1/lua/plugins/bootstrap.lua#L47
    config = function()
      require("telescope").load_extension("notify")
      -- https://github.com/ecosse3/nvim/blob/cbe9028039658591210bf1d44ffa41605a8b6f69/lua/config/plugins.lua#L323
      require("notify").setup({
        -- https://github.com/rcarriga/nvim-notify/issues/188
        -- https://www.reddit.com/r/neovim/comments/z7aqw0/comment/j0pe3ln/
        -- https://github.com/alpha2phi/modern-neovim/blob/eb688331b2f44b2fa35a5f26d7856322b92d1e53/lua/plugins/init.lua#L41
        -- setting this in opts doesn't work
        background_colour = "#ff0000",
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
}
