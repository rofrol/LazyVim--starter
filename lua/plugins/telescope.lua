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
        require("grapple").app():tag({path = j.path})
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

local vimgrep_args = {
    "rg",
    "--follow",        -- Follow symbolic links
    "--no-heading",    -- Don't group matches by each file
    "--with-filename", -- Print the file path with the matched lines
    "--line-number",   -- Show line numbers
    "--column",        -- Show column numbers
    "--smart-case",    -- Smart case search

    -- Exclude some patterns from search
    "--glob=!**/.git/*",
    "--glob=!**/.idea/*",
    "--glob=!**/.vscode/*",
    "--glob=!**/build/*",
    "--glob=!**/dist/*",
    "--glob=!**/yarn.lock",
    "--glob=!**/package-lock.json",
    "--glob=!**/node_modules/*",
    "--glob=!**/.angular/*",
  }

local function toggle_vimgrep_args()
  -- Define your new temporary vimgrep arguments
  local vimgrep_args_hidden = {
    "rg",
    "--follow",        -- Follow symbolic links
    "--hidden",        -- Search for hidden files
    "--no-heading",    -- Don't group matches by each file
    "--with-filename", -- Print the file path with the matched lines
    "--line-number",   -- Show line numbers
    "--column",        -- Show column numbers
    "--smart-case",    -- Smart case search

    -- Exclude some patterns from search
    "--glob=!**/.git/*",
    "--glob=!**/.idea/*",
    "--glob=!**/.vscode/*",
    "--glob=!**/build/*",
    "--glob=!**/dist/*",
    "--glob=!**/yarn.lock",
    "--glob=!**/package-lock.json",
    "--glob=!**/node_modules/*",
    "--glob=!**/.angular/*",
  }

  -- Set the new temporary vimgrep arguments
  require('telescope.config').values.vimgrep_arguments = vimgrep_args_hidden

  -- Perform your telescope search
  require('telescope.builtin').live_grep()

  -- Reset to original vimgrep arguments after the search is done
  require('telescope.config').values.vimgrep_arguments = vimgrep_args
end

local Util = require("helpers.util")
Util.map('n', '<leader>tg', toggle_vimgrep_args)

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "natecraddock/telescope-zf-native.nvim",
      "cbochs/grapple.nvim",
      config = function()
        require("telescope").load_extension("zf-native")
      end,
    },
    opts = {
      defaults = {
        -- does not ignore package-lock.json somehow
        -- https://stackoverflow.com/questions/71809098/how-to-include-specific-hidden-file-folder-in-search-result-when-using-telescope/72545476#72545476
        -- file_ignore_patterns = {
        -- "node_modules", "build", "dist", "yarn.lock", ".angular", ".git", "package-lock.json", ".vscode"
        -- },
        -- ignores package-lock.json
        -- https://stackoverflow.com/questions/71809098/how-to-include-specific-hidden-file-folder-in-search-result-when-using-telescope/76991432#76991432
        vimgrep_arguments = vimgrep_args,
        pickers = {
          -- does not ignore package-lock.json
          find_files = {
            hidden = true,
            -- needed to exclude some files & dirs from general search
            -- when not included or specified in .gitignore
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob=!**/.git/*",
              "--glob=!**/.idea/*",
              "--glob=!**/.vscode/*",
              "--glob=!**/build/*",
              "--glob=!**/dist/*",
              "--glob=!**/yarn.lock",
              "--glob=!**/package-lock.json",
            },
          },
        },
        -- layout_strategy = "horizontal",
        -- layout_config = { prompt_position = "top" },
        -- sorting_strategy = "ascending",
        -- winblend = 0,
        -- https://www.reddit.com/r/neovim/comments/r22xrq/comment/hm2dv20/
        layout_strategy = "flex",
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
            -- error module 'telescope.actions' not found
            -- ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
            -- ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
            -- ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
            -- ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
            -- ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
            -- ["<C-;>"] = require("telescope.actions").move_selection_next,
            ["<C-n>"] = false,
          }
        },
      }
    }
  },
}
