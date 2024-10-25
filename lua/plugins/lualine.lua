local Util = require("helpers.util")
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "cbochs/grapple.nvim", "asyncedd/wpm.nvim", { 'echasnovski/mini.icons', version = false } },
    config = function(_, opts)
      -- https://github.com/ThePrimeagen/harpoon/issues/352#issuecomment-1873053256
      function Grapple_files()
        local MiniIcons = require('mini.icons')
        local Grapple = require("grapple")
        local app = Grapple.app()
        opts = vim.tbl_deep_extend("keep", opts or {}, app.settings.statusline)
        local tags = Grapple.tags()
        local current = Grapple.find({ buffer = 0 })
        local output = {}

        local active_previous = false;
        local length = Util.getTableSize(tags)
        -- https://neovim.discourse.group/t/how-can-i-get-size-of-my-current-workspace/1876/5
        -- https://vi.stackexchange.com/questions/37530/how-to-get-total-width-of-vim-with-vertical-splits/37531#37531
        local trunc_len = math.floor((vim.o.columns - length * 7 ) / length)
        if tags ~= nil then
          for index, tag in ipairs(tags) do
            -- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#truncating-components-in-smaller-window
            -- https://github.com/nvim-lualine/lualine.nvim/issues/225
            local f = vim.fn.fnamemodify(tag.path, ":t")
            local sep = trunc_len < #f and '…' or ' '
            local file_name = f:sub(1, trunc_len)..sep..MiniIcons.get('file', f)

            if current and current.path == tag.path then
              local left = ""
              if index == 1 then
                left = ""
              end
              local right = ""
              local last = "%#GrappleActiveClosingTriangle#"
              if index == length then
                last = "%#GrappleActiveClosingTriangleLast#"
              end
              active_previous = true
              table.insert(output, string.format("%%#GrappleActiveOpeningTriangle#%s%%#GrappleNumberActive# %s %%#GrappleActive#%s %s%s", left, index, file_name, last, right))
            else
              local left = ""
              if index == 1 or active_previous then
                left = ""
              end
              local last = "%#GrappleInactiveClosingTriangle#"
              local right = ""
              if index == length then
                last = "%#GrappleInactiveClosingTriangleLast#"
                right = ""
              end
              active_previous = false
              table.insert(output, string.format("%%#GrappleBg#%%#GrappleInactiveOpeningTriangle#%s%%#GrappleNumberInctive# %s %%#GrappleInactive#%s %s%s", left, index, file_name, last, right))
            end
          end
        end

        local statusline = table.concat(output, '')
        -- if opts.include_icon then
        --   statusline = string.format("%s %%#GrappleIcon# %s", statusline, opts.icon)
        -- end

        return "%#GrappleIcon# 🕇😄 "..statusline
      end

      -- fancy widget to display words per minute graph
      -- local wpm = require("wpm")
      -- wpm.setup({})

      -- table.insert(opts.sections.lualine_a, function() return "✞" end)
      -- prepend with 1
      -- https://stackoverflow.com/questions/71299599/how-to-prepend-an-item-to-lua-array/71299679#71299679
      -- table.insert(opts.sections.lualine_z, 1, "location")
      -- table.insert(opts.sections.lualine_z, 1, wpm.wpm)
      -- table.insert(opts.sections.lualine_z, 1, wpm.historic_graph)

      require('lualine').setup {
        -- options = { section_separators = '', component_separators = '' },
        sections = {
          lualine_z = {
            "location",
            "%L",
            -- wpm.wpm,
            -- wpm.historic_graph,
            -- https://stackoverflow.com/questions/50478236/lua-spread-operator-on-an-array/50478498#50478498
            unpack(opts.sections.lualine_z),
          },
        },
        tabline = {
          lualine_a = {
            {
              Grapple_files,
              -- setting bg is needed to disable right separator. bug?
              -- https://www.reddit.com/r/neovim/comments/18s7185/help_with_lualines_component_separators/
              color = { bg = '#ffffff' },
              icons_enabled = false,
              icon = nil,
              separator = nil,
              padding = 0,
            }
          },
        },
      }
    end,
  },
}
