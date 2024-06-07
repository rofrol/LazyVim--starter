return {
  {
    'nanozuki/tabby.nvim',
    -- event = 'VimEnter', -- if you want lazy load, see below
    dependencies = "tiagovla/scope.nvim",
    config = function()
      require("scope").setup({})
    end,
  }
}
