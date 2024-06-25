return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "cbochs/grapple.nvim", "asyncedd/wpm.nvim" },
    config = function(_, opts)
      -- https://github.com/ThePrimeagen/harpoon/issues/352#issuecomment-1873053256
      function Grapple_files()
        local Grapple = require("grapple")
        local app = Grapple.app()
        opts = vim.tbl_deep_extend("keep", opts or {}, app.settings.statusline)
        local tags = Grapple.tags()
        local current = Grapple.find({ buffer = 0 })
        local output = {}

        if tags ~= nil then
          for index, tag in ipairs(tags) do
            local file_name = vim.fn.fnamemodify(tag.path, ":t")

            if current and current.path == tag.path then
              table.insert(output, string.format("%%#GrappleActiveOpeningTriangle#◢%%#GrappleNumberActive# %s%%#GrappleActive# %s %%#GrappleActiveClosingTriangle#◣", index, file_name))
            else
              table.insert(output, string.format("%%#GrappleBg#%%#GrappleInactiveOpeningTriangle#◢%%#GrappleNumberInctive# %s%%#GrappleInactive# %s %%#GrappleInactiveClosingTriangle#◣", index, file_name))
            end
          end
        end

        local statusline = table.concat(output, ' ')
        if opts.include_icon then
          statusline = string.format("%s %%#GrappleIcon# %s", statusline, opts.icon)
        end

        return statusline
      end

      local wpm = require("wpm")
      wpm.setup({})

      -- table.insert(opts.sections.lualine_a, function() return "✞" end)
      -- prepend with 1
      -- https://stackoverflow.com/questions/71299599/how-to-prepend-an-item-to-lua-array/71299679#71299679
      -- table.insert(opts.sections.lualine_z, 1, "location")
      -- table.insert(opts.sections.lualine_z, 1, wpm.wpm)
      -- table.insert(opts.sections.lualine_z, 1, wpm.historic_graph)

      require('lualine').setup {
        sections = {
          lualine_a = {
            function() return "✞" end,
            unpack(opts.sections.lualine_a),
          },
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
              Grapple_files,
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
