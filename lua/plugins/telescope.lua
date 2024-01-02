-- this works https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
-- https://github.com/nvim-telescope/telescope.nvim/issues/814#issuecomment-1781603898
-- https://github.com/nvim-telescope/telescope.nvim/pull/807#issuecomment-1703960904
-- https://stackoverflow.com/questions/22142755/what-is-the-meaning-of-a-cr-at-the-end-of-some-vim-mappings
local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        -- vim.cmd(string.format('%s %s', 'edit', j.path))
        require("harpoon.mark").add_file(j.path)
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

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
        mappings = {
          i = {
            -- This allows the user to map <CR>. If multiple file selections are detected, it will edit/open each file. If hitting <CR> on a single selection, it'll fall back to actions.select_default...
            -- CR means carriage return (Enter key) https://stackoverflow.com/questions/22142755/what-is-the-meaning-of-a-cr-at-the-end-of-some-vim-mappings
            -- select with Tab (goes up) or Shift-Tab.
            -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            -- https://github.com/nvim-telescope/telescope.nvim/blob/3466159b0fcc1876483f6f53587562628664d850/lua/telescope/mappings.lua#L179
            ['<CR>'] = select_one_or_multi,
            ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
          }
        },
      },
    },
  },
}
