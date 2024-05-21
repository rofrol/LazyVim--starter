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

      -- https://github.com/evertonlopesc/nvim/blob/8000d26e8d3d0f63382520f14b048b2691696573/lua/keymaps/init.lua#L48
      -- https://github.com/insanum/dotfiles/blob/d40c677c64a5f14f00ecc0f9f7833304bb0bd483/config/nvim/lua/lazy_overrides.lua#L300
      -- https://github.com/tjdevries/config_manager/blob/afbb6942b712174a7e87acbca6908e283caa46cc/xdg_config/nvim/after/plugin/harpoon.lua#L16
      for i = 1, 6, 1 do
        vim.keymap.set(
          { "i", "x", "n", "s" },
          (vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM ~= "iTerm.app") and string.format("<D-%s>", i) or string.format("<leader>%s", i),
          '<cmd>lua require("harpoon.ui").nav_file(' .. i .. ')<CR>',
          { desc = string.format('Harpoon file %s', i), expr = false, noremap = true, silent = true }
        )
      end
    end,
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add harpoon mark",
        opts,
      },
      {
        "<leader>j",
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
      -- {
      --   vim.fn.has("mac") == 1 and "<D-1>" or "<leader>1",
      --   -- "<leader>1",
      --   function()
      --     require("harpoon.ui").nav_file(1)
      --   end,
      --   opts,
      -- },
    },
  },
}
