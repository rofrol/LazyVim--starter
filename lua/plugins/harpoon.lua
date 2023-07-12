local opts = { noremap = true, silent = true }

return {
  {
    "ThePrimeagen/harpoon",
    opts = {
      global_settings = {
        tabline = true,
        tabline_prefix = "   ",
        tabline_suffix = "   ",
      },
      menu = {
        width = vim.api.nvim_win_get_width(0) - 10,
      },
    },
    config = function()
      vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
      vim.cmd("highlight! HarpoonActive guibg=NONE guifg=black")
      vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
      vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
      vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
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
        "<M-1>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        opts,
      },
      {
        "<M-2>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        opts,
      },
      {
        "<M-3>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        opts,
      },
      {
        "<M-4>",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        opts,
      },
      {
        "<M-5>",
        function()
          require("harpoon.ui").nav_file(5)
        end,
        opts,
      },
      {
        "<M-6>",
        function()
          require("harpoon.ui").nav_file(6)
        end,
        opts,
      },
      {
        "<M-7>",
        function()
          require("harpoon.ui").nav_file(7)
        end,
        opts,
      },
      {
        "<M-8>",
        function()
          require("harpoon.ui").nav_file(8)
        end,
        opts,
      },
      {
        "<M-9>",
        function()
          require("harpoon.ui").nav_file(9)
        end,
        opts,
      },
    },
  },
}
