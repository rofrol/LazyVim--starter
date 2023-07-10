-- HIGHLIGHTING FIX
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#d79921", sp = "#d79921", underline = true })
vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#d79921", sp = "#d79921", underline = true })
vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#d79921", sp = "#d79921", underline = true })

-- local editor_layout = require("builtin.utils.layout").editor
-- local MAX_NAME_LENGTH = editor_layout.width(0.334, 15, 80)

return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     -- do I need this?
  --     vim.list_extend(opts.ensure_installed, {
  --       "tsx",
  --       "typescript",
  --     })
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        -- https://www.reddit.com/r/neovim/comments/xzhty5/comment/irmgu2m/
        keyword = "fg",
      },
    },
  },
  "ziglang/zig",
  { "echasnovski/mini.pairs", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            -- "node_modules",
          },
        },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]], -- non-floating terminal
        shade_terminals = false,
        -- add --login so ~/.zprofile is loaded
        -- https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile/16021#16021
        shell = "zsh --login",
      })
    end,
    keys = {
      -- https://github.com/LazyVim/LazyVim/discussions/193#discussioncomment-6088989
      { [[<C-\>]] }, -- non-floating terminal
      -- { "<leader>0", "<Cmd>2ToggleTerm size=60 direction=horizontal<Cr>", desc = "Terminal #2" },
      { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },
  { "goolord/alpha-nvim", enabled = false },
  { "neovim/nvim-lspconfig", opts = { inlay_hints = { enabled = true } } },
  {
    "akinsho/bufferline.nvim",
    opts = {
      -- https://github.com/giusgad/dotfiles/blob/ed81c1cb5c92aa1216267710cb037f55a6140da2/.config/nvim/lua/plugins/config/bufferline.lua#L43
      options = {
        tab_size = 30,
        separator_style = { "", "" }, -- | "thick" | "thin" | { 'left', 'right' },
        indicator = { style = "underline", icon = "" }, -- underline style is based on terminal

        -- max_name_length = 40,
        -- https://github.com/akinsho/bufferline.nvim/blob/2f391fde91b9c3876eee359ee24cc352050e5e48/lua/bufferline/ui.lua#L367C32-L367C46
        truncate_names = true,
        autosize = true,
        -- https://github.com/linrongbin16/lin.nvim/blob/75c9ab963171f18b05d3d549d00fdc7f7b8331a4/lua/configs/akinsho/bufferline-nvim/config.lua#L13C1-L23C13
        -- name_formatter = function(buf)
        --   local name = buf.name
        --   local len = name ~= nil and string.len(name) or 0
        --   if len > MAX_NAME_LENGTH then
        --     local half = math.floor(MAX_NAME_LENGTH / 2) - 1
        --     local left = string.sub(name, 1, half)
        --     local right = string.sub(name, len - half, len)
        --     name = left .. "…" .. right
        --   end
        --   return name
        -- end,
        -- https://github.com/giusgad/dotfiles/blob/ed81c1cb5c92aa1216267710cb037f55a6140da2/.config/nvim/lua/plugins/config/bufferline.lua#L24C1-L30C13
        -- name_formatter = function(buf)
        --   if vim.startswith(buf.name, "index") or vim.startswith(buf.name, "page") then
        --     name = string.match(buf.path, ".*[\\/](.-)[\\/](.-)$")
        --     return name .. "/" .. buf.name
        --   end
        --   return buf.name
        -- end,
        -- https://github.com/tuyentv96/.dotfiles/blob/dda782503d278edfd382ca51001e6033806f82f0/nvim/.config/nvim/lua/plugins/config/bufferline.lua#L33C1-L35C8
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
          return buf.name
        end,
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 10,
      },
    },
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add harpoon mark",
      },
      {
        "<leader>j",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon toogle quick menu",
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
    },
  },
}
