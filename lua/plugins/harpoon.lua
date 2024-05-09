local opts = { silent = true }

return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "echasnovski/mini.bufremove" },
    lazy = false, -- any lazy handler triggers lazy loading. i.e. keymaps
    config = function()
      vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
      vim.cmd("highlight! HarpoonActive guibg=NONE guifg=black")
      vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
      vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
      vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")

      require("harpoon").setup({
        tabline = true,
        menu = {
          width = vim.api.nvim_win_get_width(0) - 20,
        },
      })
    end,
    keys = {
      {
        "<leader>ha",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add harpoon mark",
        opts,
      },
      {
        "<leader>hj",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon toogle quick menu",
        opts,
      },
      {
        "<space>hc",
        function()
          require("harpoon.mark").clear_all()
        end,
        opts,
      },
      {
        "<space>ht",
        function()
          local index = require("harpoon.mark").get_current_index()
          if index ~= nil then
            local config = require('harpoon').get_mark_config()
            table.remove(config.marks, index)
            local global_settings = require("harpoon").get_global_settings()
            if global_settings.tabline then
              vim.cmd("redrawt")
            end
          end
          require("mini.bufremove").delete(0, true)
        end,
        opts,
        desc = "Harpoon remove file",
      },
      {
        "<S-h>",
        function()
          require("harpoon.ui").nav_prev()
        end,
        opts,
      },
      {
        "<S-l>",
        function()
          require("harpoon.ui").nav_next()
        end,
        opts,
      },
      {
        "<leader>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        opts,
      },
      {
        "<leader>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        opts,
      },
      {
        "<leader>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        opts,
      },
      {
        "<leader>4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        opts,
      },
      {
        "<leader>5",
        function()
          require("harpoon.ui").nav_file(5)
        end,
        opts,
      },
      {
        "<leader>6",
        function()
          require("harpoon.ui").nav_file(6)
        end,
        opts,
      },
      {
        "<leader>7",
        function()
          require("harpoon.ui").nav_file(7)
        end,
        opts,
      },
      {
        "<leader>8",
        function()
          require("harpoon.ui").nav_file(8)
        end,
        opts,
      },
      {
        "<leader>9",
        function()
          require("harpoon.ui").nav_file(9)
        end,
        opts,
      },
    },
  },
}
