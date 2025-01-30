-- if true then return {} end
local Util = require("helpers.util")
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>j", group = "grapple" },
        { "<leader>o", group = "spell" },
        { "<leader>t", group = "terminal" },
        { "<leader>z", group = "misc" },
      }
    },
  },
  -- { "Olical/nfnl",            ft = "fennel" },
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
  { "echasnovski/mini.pairs", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      tabline = true,
      tabline_icons = true,
      tabline_prefix = "   ",
      window = {
        position = "right",
        mappings = {
          ["e"] = function()
            vim.api.nvim_exec("Neotree focus filesystem right", true)
          end,
          ["b"] = function()
            vim.api.nvim_exec("Neotree focus buffers right", true)
          end,
          ["g"] = function()
            vim.api.nvim_exec("Neotree focus git_status right", true)
          end,
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
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
        -- does not work -> https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#harpoon-index
        -- below works ok
        -- components = {
        --   harpoon_index = function(config, node, _)
        --     local Marked = require("harpoon.mark")
        --     local path = node:get_id()
        --     local success, index = pcall(Marked.get_index_of, path)
        --     if success and index and index > 0 then
        --       return {
        --         text = string.format("%d ", index), -- <-- Add your favorite harpoon like arrow here
        --         highlight = config.highlight or "NeoTreeDirectoryIcon",
        --       }
        --     else
        --       return {
        --         text = "  ",
        --       }
        --     end
        --   end,
        --   space = function(config, node, _)
        --     return {
        --       text = "  ",
        --     }
        --   end,
        -- },
        renderers = {
          file = {
            -- { "harpoon_index" }, --> This is what actually adds the component in where you want it
            { "icon" },
            { "name",       use_git_status_colors = true },
            { "diagnostics" },
            { "git_status", highlight = "NeoTreeDimText" },
          },
          -- from lazy/neo-tree.nvim/lua/neo-tree/defaults.lua
          directory = {
            -- { "space" },
            { "indent" },
            { "icon" },
            { "current_filter" },
            {
              "container",
              content = {
                { "name",          zindex = 10 },
                {
                  "symlink_target",
                  zindex = 10,
                  highlight = "NeoTreeSymbolicLinkTarget",
                },
                { "clipboard",     zindex = 10 },
                { "diagnostics",   errors_only = true, zindex = 20,     align = "right",          hide_when_expanded = true },
                { "git_status",    zindex = 10,        align = "right", hide_when_expanded = true },
                { "file_size",     zindex = 10,        align = "right" },
                { "type",          zindex = 10,        align = "right" },
                { "last_modified", zindex = 10,        align = "right" },
                { "created",       zindex = 10,        align = "right" },
              },
            },
          },
        },
      },
      buffers = {
        follow_current_file = {
          leave_dirs_open = true,
        },
        window = {
          mappings = {
            -- disable Y mapping for warning: invalid mapping for Y nil
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/1324
            ["Y"] = "noop"
          }
        },
      },
      git_status = {
        window = {
          mappings = {
            -- disable Y mapping for warning: invalid mapping for Y nil
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/1324
            ["Y"] = "noop"
          }
        },
      },
    },
    keys = {
      {
        "<leader>r",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            -- dir = require("lazyvim.util").get_root(),
            source = "buffers",
            position = "right",
          })
        end,
        desc = "Buffers (root dir)",
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
        -- shell = "zsh --login",
        -- shell = "nu",
        start_in_insert = true,
        persist_mode = false,
        size = function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
          end
          return 20
        end,
      })
    end,
    keys = function()
      local zigbuild = require('toggleterm.terminal').Terminal:new({
        direction = "vertical",
        cmd = "watchexec -e zig -c -r zig build",
        hidden = false
      })
      local bun = function()
        local filename = vim.fn.expand("%:p")
        local basedir = vim.fn.fnamemodify(filename, ":h")
        local cmd = "cd " .. basedir .. " && bun --watch " .. filename
        print(cmd)
        return require('toggleterm.terminal').Terminal:new({
          direction = "vertical",
          cmd = cmd,
          hidden = false
        })
      end
      local ng_serve = function()
        local cmd = "cd " .. vim.fs.root(0, '.git') .. " && ng s"
        print(cmd)
        return require('toggleterm.terminal').Terminal:new({
          direction = "horizontal",
          cmd = cmd,
          hidden = false
        })
      end
      -- on_load copied from lazy/LazyVim/lua/lazyvim/plugins/extras/coding/copilot-chat.lua
      -- require("which-key").register(which_key_table)
      local keys = {
        -- https://github.com/LazyVim/LazyVim/discussions/193#discussioncomment-6088989
        { [[<C-\>]] }, -- non-floating terminal
        -- { "<leader>0", "<Cmd>2ToggleTerm size=60 direction=horizontal<Cr>", desc = "Terminal #2" },
        { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
        { "<leader>-", "<Cmd>3ToggleTerm<Cr>", desc = "Terminal #2" },
        { "<M-2>",     "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
        { "<M-3>",     "<Cmd>3ToggleTerm<Cr>", desc = "Terminal #3" },
        { "<M-4>",     "<Cmd>4ToggleTerm<Cr>", desc = "Terminal #4" },
        {
          "<leader>tv",
          function()
            local term = require("toggleterm.terminal").Terminal:new({
              direction = "vertical",
            })
            term:toggle()
            -- settings size in Terminal:new does not work when direction is vertical
            vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.33))
          end,
          desc = "Open terminal with 1/3 width"
        },
        {
          "<leader>tz",
          function()
            zigbuild:toggle()
            -- settings size in Terminal:new does not work when direction is vertical
            vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.33))
          end,
          desc = "Open terminal with watchexec zig build with 1/3 width"
        },
        {
          "<leader>tb",
          function()
            bun():toggle()
            vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.33))
          end,
          desc = "Run bun with current file in terminal with 1/3 width"
        },
        {
          "<leader>ts",
          function()
            ng_serve():toggle()
            -- vim.cmd("horizontal resize " .. math.floor(vim.o.rows * 0.33))
          end,
          desc = "Run ng s in terminal with 1/3 height"
        },
      }
      return keys
    end,
  },
  {
    -- interesting noice config
    -- https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/noice-and-notification.lua
    "folke/noice.nvim",
    opts = {
      views = {
        cmdline_popup = {
          size = { width = 100 },
          position = {
            row = -2,
            col = 0,
          },
        },
      },
      -- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages
      -- https://www.reddit.com/r/neovim/comments/12lf0ke/comment/jg6idvr/
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
          },
          opts = { skip = true },
        },
      },
      cmdline = {
        view = "cmdline",
        position = {
          row = -2,
        },
      },
      -- Turn off documentation popup
      -- https://www.reddit.com/r/neovim/comments/1bri8a3/comment/kx9haec/
      lsp = {
        signature = {
          auto_open = {
            enabled = false,
          },
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      -- https://matrix.to/#/!cylwlNXSwagQmZSkzs:matrix.org/$8VJ5mcCGehBtU6Mu79JNbWZid3Q1E4SlObYCNwM7crg
      -- https://github.com/evertonlopesc/nvim/blob/6480813d7cbe08fbf915164ad4d247075ccf41e1/lua/plugins/bootstrap.lua#L47
      -- https://github.com/ecosse3/nvim/blob/cbe9028039658591210bf1d44ffa41605a8b6f69/lua/config/plugins.lua#L323
      -- https://github.com/rcarriga/nvim-notify/issues/188
      -- https://www.reddit.com/r/neovim/comments/z7aqw0/comment/j0pe3ln/
      -- https://github.com/alpha2phi/modern-neovim/blob/eb688331b2f44b2fa35a5f26d7856322b92d1e53/lua/plugins/init.lua#L41
      background_colour = "Normal",
      top_down = false,
      fps = 60,
      stages = "static",
      timeout = 3000,
      on_open = function(win)
        local height = vim.api.nvim_win_get_height(win)
        local width = vim.api.nvim_win_get_width(win)
        local row = vim.api.nvim_win_get_position(win)[1]
        local col = vim.api.nvim_win_get_position(win)[2]
        vim.api.nvim_win_set_config(win, {
          relative = "editor",
          row = row - height - 1,
          col = col + width / 2,
          anchor = "NW",
        })
      end,
    },
  },
  { "nvimdev/dashboard-nvim", enabled = false },
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      --,autoformat = false
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    opts = {
      -- https://github.com/giusgad/dotfiles/blob/ed81c1cb5c92aa1216267710cb037f55a6140da2/.config/nvim/lua/plugins/config/bufferline.lua#L43
      options = {
        tab_size = 30,
        separator_style = { "", "" },                   -- | "thick" | "thin" | { 'left', 'right' },
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
    "RaafatTurki/hex.nvim",
    config = function()
      require("hex").setup()
    end,
    keys = {
      { "<leader>bb", "<Cmd>:lua require('hex').dump()<Cr>",     desc = "hex" },
      { "<leader>bn", "<Cmd>:lua require('hex').assemble()<Cr>", desc = "normal" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          -- https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md#md013---line-length
          -- https://github.com/itsdmd/nvim/blob/ef068f6f9245e798e1da4066befd3950188b5ed6/lua/plugins/markdownlint.lua#L3§
          args = { "-r", "~MD013,~MD034", "--" },
        },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        options = {
          -- signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,   -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
      },
    },
    keys = {
      { "<leader>zm", "<Cmd>:ZenMode<Cr>", desc = "ZenMode" },
    },

  },
  {
    "folke/twilight.nvim",
    enabled = false,
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#000000" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false,    -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
    }
  },
  {
    "gbprod/substitute.nvim",
    dependencies = { "gbprod/yanky.nvim" },
    -- Do not copy to clipboard on paste in visual mode with yanky
    -- https://www.reddit.com/r/neovim/comments/xvaj1u/comment/isww3iw/
    keys = {
      { mode = "x", "p", "<cmd>lua require('substitute').visual()<cr>", desc = "substitute" },
      { mode = "x", "P", "<cmd>lua require('substitute').visual()<cr>", desc = "substitute" },
    },
    config = function()
      require("substitute").setup({
        on_substitute = require("yanky.integration").substitute(),
      })
    end,
  },
  { "lukas-reineke/headlines.nvim", enabled = false },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "markdownlint-cli2" },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdownlint-cli2" })
    end,
  },
  {
    "echasnovski/mini.surround",
    opts = function()
      Util.map('n', '<leader>za', 'gsaiw`wl',
        { remap = true, desc = 'mini.surround: wrap with backtick (`) and go to the end' })
      Util.map('v', '<leader>za', 'gsa``>lll',
        { remap = true, desc = 'mini.surround: wrap with backtick (`) and go to the end' })
    end
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   config = function ()
  --     -- https://github.com/22a/dotfiles/blob/eb4c08fd58ae9e654f34682a8d1e137f99f4cac5/init.lua#L311
  --     require('nvim-treesitter.configs').setup {
  --       highlight = {
  --         enable = false,
  --         disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
  --       },
  --     }
  --   end
  -- },
  -- disabling because it hides code blocks ```
  { 'MeanderingProgrammer/render-markdown.nvim', enabled = false },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --     --https://github.com/davvil/nvim_config/blob/3e97063a82190d853fc5c29c54e5b049fb436b60/lua/plugins/plugins.lua#L61
  --   opts = {
  --     anti_conceal = {
  --       enabled = false,
  --       ignore = {
  --         code_background = true,
  --         code_language = true,
  --         code_background = true,
  --         code_border = true,
  --       },
  --     },
  --     checkbox = { enabled = false },
  --     heading = { enabled = false },
  --     bullet = { enabled = false },
  --     code = { enabled = false },
  --   }
  -- },
  {
    'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    keys = {
      { mode = "n", "<leader>fo", "<cmd>Oil --float<cr>", desc = "Oil --float" },
      { mode = "n", "<leader>fO", "<cmd>Oil<cr>", desc = "Oil" },
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require("oil").setup({
        use_default_keymaps = true,
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          is_always_hidden = function(name, bufnr)
            return false
          end,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        float = {
          padding = 1,
          max_width = 60,
          max_height = 16,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          override = function(conf)
            return conf
          end,
        },

        preview = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = 0.9,
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },

        keymaps = {
          -- ["<C-c>"] = false,
          ["q"] = "actions.close",
          ["h"] = "actions.parent",
          ["l"] = "actions.select",
          -- ["g?"] = "actions.show_help",
          -- ["<CR>"] = "actions.select",
          -- ["<C-s>"] = "actions.select_vsplit",
          -- ["<C-h>"] = "actions.select_split",
          -- ["<C-t>"] = "actions.select_tab",
          -- ["<C-p>"] = "actions.preview",
          -- ["<C-c>"] = "actions.close",
          -- ["<C-l>"] = "actions.refresh",
          -- ["-"] = "actions.parent",
          -- ["_"] = "actions.open_cwd",
          -- ["`"] = "actions.cd",
          -- ["~"] = "actions.tcd",
          -- ["gs"] = "actions.change_sort",
          -- ["g."] = "actions.toggle_hidden",
        },
      })

      -- require("oil").setup({
      --   default_file_explorer = true,
      --   delete_to_trash = true,
      --   skip_confirm_for_simple_edits = true,
      --   view_options = {
      --     show_hidden = true,
      --     natural_order = true,
      --     is_always_hidden = function(name, _)
      --       return name == ".." or name == ".git"
      --     end,
      --   },
      --   float = {
      --     padding = 2,
      --     max_width = 90,
      --     max_height = 0,
      --   },
      --   win_options = {
      --     wrap = true,
      --     winblend = 0,
      --   },
      --   keymaps = {
      --     ["<C-c>"] = false,
      --     ["q"] = "actions.close",
      --   },
      -- })
    end,
  },
  {
    "albenisolmos/telescope-oil.nvim",
    dependencies = {
      { "stevearc/oil.nvim", opts = {} },
    },
    keys = {
      { mode = "n", "<leader>to", "<cmd>Telescope oil<cr>", desc = "Telescope Oil" },
    },
    config = function()
        -- optionally override defaults
        -- local settings = require("telescope-oil.settings")
        -- settings.set({ hidden = true })
        -- settings.set({ no_ignore = false })
        -- settings.set({ show_preview = true })

        -- load extension
        require("telescope").load_extension("oil")
    end
  },
  { 'echasnovski/mini.files', version = '*',
    opts = {
      windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = true,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 50,
      },
    },
  },
}
