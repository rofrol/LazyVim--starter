-- Parser not available for language "help"
-- https://github.com/LazyVim/LazyVim/issues/524#issuecomment-1496370991
-- https://www.reddit.com/r/neovim/comments/12b94bp/comment/jf2m8eb/
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ignore_install = { "help" }
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      -- https://www.reddit.com/r/neovim/comments/z7aqw0/comment/j0pe3ln/
      -- https://github.com/alpha2phi/modern-neovim/blob/eb688331b2f44b2fa35a5f26d7856322b92d1e53/lua/plugins/init.lua#L41
      background_colour = "#1a1b26",
    },
    -- https://github.com/evertonlopesc/nvim/blob/6480813d7cbe08fbf915164ad4d247075ccf41e1/lua/plugins/bootstrap.lua#L47
    config = function()
      require("telescope").load_extension("notify")
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
}
