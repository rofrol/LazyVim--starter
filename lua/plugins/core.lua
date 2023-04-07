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
}
