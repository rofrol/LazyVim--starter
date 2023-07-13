return {
  {
    "telescope.nvim",
    dependencies = {
      "natecraddock/telescope-zf-native.nvim",
      config = function()
        require("telescope").load_extension("zf-native")
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      defaults = {
        -- layout_strategy = "horizontal",
        -- layout_config = { prompt_position = "top" },
        -- sorting_strategy = "ascending",
        -- winblend = 0,
        -- https://www.reddit.com/r/neovim/comments/r22xrq/comment/hm2dv20/
        layout_strategy = "vertical",
        layout_config = {
          height = 0.95,
          -- preview_width = 0.65,
          -- https://www.reddit.com/r/neovim/comments/q05oo8/getting_the_telescope_dialog_to_span_the_more_of/
          -- https://www.reddit.com/r/neovim/comments/yrqm9f/comment/ivv8hoa/
          -- width = function(_, cols, _)
          --   if cols > 200 then
          --     return 170
          --   else
          --     return math.floor(cols * 0.87)
          --   end
          -- end,
        },
      },
    },
  },
}
