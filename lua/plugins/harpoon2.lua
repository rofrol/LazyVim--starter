if true then return {} end
return {
  {
    "ThePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    dependencies = {
      -- "CWood-sdf/harpoontabline",
    },
    keys = function()
      local keys = {
        {
          "<leader>a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 9 do
        table.insert(keys, {
          "<leader>" .. i,
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
            contents[index] = string.format("%%#HarpoonNumberActive# %s%%#HarpoonActive# %s ", index, file_name)
          else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s%%#HarpoonInactive# %s ", index, file_name)
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
