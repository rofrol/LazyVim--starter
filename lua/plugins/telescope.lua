return {
  -- add telescope-fzf-native
  -- {
  --   "telescope.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = "make",
  --     config = function()
  --       require("telescope").load_extension("fzf")
  --     end,
  --   },
  -- },

  {
    "telescope.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
      -- https://github.com/evertonlopesc/nvim/blob/6480813d7cbe08fbf915164ad4d247075ccf41e1/lua/plugins/bootstrap.lua#L47
      config = function()
        require("telescope").load_extension("notify")
        -- https://github.com/ecosse3/nvim/blob/cbe9028039658591210bf1d44ffa41605a8b6f69/lua/config/plugins.lua#L323
        require("notify").setup({
          -- https://github.com/rcarriga/nvim-notify/issues/188
          -- https://www.reddit.com/r/neovim/comments/z7aqw0/comment/j0pe3ln/
          -- https://github.com/alpha2phi/modern-neovim/blob/eb688331b2f44b2fa35a5f26d7856322b92d1e53/lua/plugins/init.lua#L41
          -- setting this in opts doesn't work
          background_colour = "#ff0000",
        })
      end,
    },
  },
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
  {
    "telescope.nvim",
    dependencies = {
      "ThePrimeagen/harpoon",
      -- https://github.com/albohlabs/dotfiles/blob/2597a6d0529e5b3dd0e4b71eea3985a68a75608d/nvim/.config/nvim/lua/plugins/harpoon.lua
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("harpoon").setup()
        require("telescope").load_extension("harpoon")
      end,
      -- https://github.com/Fymyte/nvim-config/blob/c9e56fe7216cdfcaa019d537b1bb1c79407b30c6/lua/fymyte/plugins/editing-tools.lua#L105
      keys = {
        {
          "<leader>a",
          function()
            require("harpoon.mark").add_file()
          end,
          desc = "[A]dd harpoon mark",
        },
        {
          "<leader>h",
          function()
            require("telescope").extensions.harpoon.marks()
          end,
          desc = "[S]earch h[A]rpoon mark",
        },
        {
          "<leader>j",
          function()
            require("harpoon.ui").toggle_quick_menu()
          end,
          desc = "[H]arpoon [T]oogle quick menu",
        },
        {
          "<leader>1",
          function()
            require("harpoon.ui").nav_file(1)
          end,
          desc = "Harpoon go to file 1",
        },
        {
          "<leader>2",
          function()
            require("harpoon.ui").nav_file(2)
          end,
          desc = "Harpoon go to file 2",
        },
        {
          "<leader>3",
          function()
            require("harpoon.ui").nav_file(3)
          end,
          desc = "Harpoon go to file 3",
        },
        {
          "<leader>4",
          function()
            require("harpoon.ui").nav_file(4)
          end,
          desc = "Harpoon go to file 4",
        },
        {
          "<leader>5",
          function()
            require("harpoon.ui").nav_file(5)
          end,
          desc = "Harpoon go to file 5",
        },
        {
          "<leader>6",
          function()
            require("harpoon.ui").nav_file(6)
          end,
          desc = "Harpoon go to file 6",
        },
        {
          "<leader>7",
          function()
            require("harpoon.ui").nav_file(7)
          end,
          desc = "Harpoon go to file 7",
        },
        {
          "<leader>8",
          function()
            require("harpoon.ui").nav_file(8)
          end,
          desc = "Harpoon go to file 8",
        },
        {
          "<leader>9",
          function()
            require("harpoon.ui").nav_file(9)
          end,
          desc = "Harpoon go to file 9",
        },
        {
          "C-.",
          function()
            require("harpoon.mark").move_mark_up()
          end,
          desc = "Harpoon move mark up",
        },
        -- map("n", "<c-n>", move_mark_down)
      },
    },
  },
}
