-- if true then return {} end
return {
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies =  { "abeldekat/harpoonline", version = "*" },
    dependencies =  { "ThePrimeagen/harpoon", "asyncedd/wpm.nvim" },
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
      wpm.setup({})

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
