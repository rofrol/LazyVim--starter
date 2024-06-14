-- if true then return {} end
return {
  {
    "ThePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} },
    dependencies = {
      -- "CWood-sdf/harpoontabline",
      "echasnovski/mini.bufremove",
    },
    keys = function()
      local opts = { noremap = true, silent = true }
      local harpoon = require("harpoon")
      local list = harpoon:list()

      -- Based on https://github.com/ThePrimeagen/harpoon/blob/0378a6c428a0bed6a2781d459d7943843f374bce/lua/harpoon/list.lua#L184
      function Remove(item)
        item = item or list.config.create_list_item(list.config)
        print("Hello")
        local Extensions = require("harpoon.extensions")
        local Logger = require("harpoon.logger")

        local items = list.items
        if item ~= nil then
          for i = 1, list._length do
            local v = items[i]
            print(vim.inspect(v))
            if list.config.equals(v, item) then
              -- this clears list somehow
              -- items[i] = nil
              table.remove(items, i)
              list._length = list._length - 1

              Logger:log("HarpoonList:remove", { item = item, index = i })

              Extensions.extensions:emit(
                Extensions.event_names.REMOVE,
                { list = list, item = item, idx = i }
              )
              break
            end
          end
        end
      end
      -- https://github.com/ThePrimeagen/harpoon/pull/400
      -- function M.get_global_settings()
      --   log.trace("get_global_settings()")
      --   return HarpoonConfig.global_settings
      -- end
      -- local function filter_filetype()
      --   local current_filetype = vim.bo.filetype
      --   local excluded_filetypes = harpoon.get_global_settings().excluded_filetypes
      --
      --   if current_filetype == "harpoon" then
      --     log.error("filter_filetype(): You can't add harpoon to the harpoon")
      --     error("You can't add harpoon to the harpoon")
      --     return
      --   end
      --
      --   if vim.tbl_contains(excluded_filetypes, current_filetype) then
      --     log.error(
      --       'filter_filetype(): This filetype cannot be added or is included in the "excluded_filetypes" option'
      --     )
      --     error(
      --       'This filetype cannot be added or is included in the "excluded_filetypes" option'
      --     )
      --     return
      --   end
      -- end
      -- function M.set_current_at(idx)
      --   filter_filetype()
      --   local buf_name = get_buf_name()
      --   log.trace("set_current_at(): Setting id", idx, buf_name)
      --   local config = harpoon.get_mark_config()
      --   local current_idx = M.get_index_of(buf_name)
      --
      --   -- Remove it if it already exists
      --   if M.valid_index(current_idx) then
      --     config.marks[current_idx] = create_mark("")
      --   end
      --
      --   config.marks[idx] = create_mark(buf_name)
      --
      --   for i = 1, M.get_length() do
      --     if not config.marks[i] then
      --       config.marks[i] = create_mark("")
      --     end
      --   end
      --
      --   emit_changed()
      -- end
      -- function Replace_or_add(item)
      --   item = item or list.config.create_list_item(list.config)
      --   print("Hello")
      --   local Extensions = require("harpoon.extensions")
      --   local Logger = require("harpoon.logger")
      --
      --   local items = list.items
      --   if item ~= nil then
      --     for i = 1, list._length do
      --       local v = items[i]
      --       print(vim.inspect(v))
      --       if list.config.equals(v, item) then
      --         -- this clears list somehow
      --         -- items[i] = nil
      --         table.remove(items, i)
      --         list._length = list._length - 1
      --
      --         Logger:log("HarpoonList:remove", { item = item, index = i })
      --
      --         Extensions.extensions:emit(
      --           Extensions.event_names.REMOVE,
      --           { list = list, item = item, idx = i }
      --         )
      --         break
      --       end
      --     end
      --   end
      -- end
      local keys = {
        {
          "<leader>a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>j",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
        {
          "<leader>h1",
          function()
            harpoon:list():replace_at(1)
          end,
          desc = 'Replace harppon mark 1 with current buffer that is not marked with harpoon',
        },
        { "<leader>hx", function() list:remove() end, mode = "n" },
        {
          "<leader>ht",
          function()
            Remove()
            require("mini.bufremove").delete(0, true)
          end,
          opts,
          desc = "Harpoon remove file",
        },
        {
          "<leader>hm",
          function()
            local item = list.config.create_list_item(list.config)

            if not list:get_by_value(item.value) then
              list:add(item)
            else
              list:remove(item)
            end
          end,
          desc = 'Toggle file',
        },
      }

      for i = 1, 9 do
        table.insert(keys, {
          mode = (vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM ~= "iTerm.app") and { "i", "x", "n", "s" } or  { "x", "n", "s" },
          (vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM ~= "iTerm.app") and string.format("<D-%s>", i) or string.format("<leader>%s", i),
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
    config = function()
      vim.cmd("highlight! HarpoonInactive guibg=#cccccc guifg=#555555")
      vim.cmd("highlight! HarpoonActive guibg=NONE guifg=#333333")
      vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
      vim.cmd("highlight! HarpoonNumberInactive guibg=#cccccc guifg=#7aa2f7")
      vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies =  { "abeldekat/harpoonline", version = "*" },
    dependencies =  { "asyncedd/wpm.nvim" },
    config = function(_, opts)
      -- https://github.com/ThePrimeagen/harpoon/issues/352#issuecomment-1873053256
      local harpoon = require('harpoon');
      function Harpoon_files()
        local contents = {}
        local marks_length = harpoon:list():length()
        local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
        for index = 1, marks_length do
          local harpoon_file_path = harpoon:list():get(index).value
          local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ':t')

          if current_file_path == harpoon_file_path then
            contents[index] = string.format("%%#HarpoonNumberActive# %s%%#HarpoonActive# %s ", index, file_name)
          else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s%%#HarpoonInactive# %s ", index, file_name)
          end
        end

        -- print(vim.inspect(table.concat(contents)))
        return table.concat(contents)
      end

      require('lualine').setup {
      }
      table.insert(opts.sections.lualine_a,
        function()
          return "😄"
        end
      )

      local wpm = require("wpm")

      -- prepend with 1
      -- https://stackoverflow.com/questions/71299599/how-to-prepend-an-item-to-lua-array/71299679#71299679
      -- table.insert(opts.sections.lualine_z, 1, "location")
      -- table.insert(opts.sections.lualine_z, 1, wpm.wpm)
      -- table.insert(opts.sections.lualine_z, 1, wpm.historic_graph)

      require('lualine').setup {
        sections = {
          lualine_a = opts.sections.lualine_a,
          -- lualine_z = opts.sections.lualine_z,
          lualine_z = {
            wpm.wpm,
            wpm.historic_graph,
            "location",
            -- https://stackoverflow.com/questions/50478236/lua-spread-operator-on-an-array/50478498#50478498
            unpack(opts.sections.lualine_z),
          },
        },
        tabline = {
          lualine_a = {
            {
              Harpoon_files,
              -- setting bg is needed to disable right separator . bug?
              -- https://www.reddit.com/r/neovim/comments/18s7185/help_with_lualines_component_separators/
              color = { bg = '#ffffff' },
            }
          },
        },
      }
    end,
  },
}
