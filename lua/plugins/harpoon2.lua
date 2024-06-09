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

      function Remove_at(item)
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
            Remove_at()
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
      vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#333333")
      vim.cmd("highlight! HarpoonActive guibg=#cccccc guifg=black")
      vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
      vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
      vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies =  { "abeldekat/harpoonline", version = "*" },
    config = function()
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
            contents[index] = string.format("%%#HarpoonNumberActive# %s %%#HarpoonActive# %s ", index, file_name)
          else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s %%#HarpoonInactive# %s ", index, file_name)
          end
        end

        -- print(vim.inspect(table.concat(contents)))
        return table.concat(contents)
      end

      require('lualine').setup {
        tabline = {
          lualine_a = { { Harpoon_files, color = { bg = '#ffffff' }, } },
        },
      }
    end,
  },
}
