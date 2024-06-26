return {
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      -- https://github.com/BSathvik/dotfiles/blob/f908c002159a7a91bf5984de7caf8b76ffc7f30b/nvim/init.lua#L600
      -- https://github.com/hrsh7th/nvim-cmp/discussions/759
      -- https://github.com/NvChad/NvChad/discussions/2397
      require("cmp").setup.filetype({ "markdown" }, {
        sources = {},
      })
    end,
  },
}
