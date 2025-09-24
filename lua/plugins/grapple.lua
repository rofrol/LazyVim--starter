-- if true then return {} end

-- when grapple does not load marks or adding new mark is not possible with error:
-- notify.error Expected the end but found invalid token at character 516
-- vim.json.decode fails in ~/.local/share/nvim/lazy/grapple.nvim/lua/grapple/state.lua
-- fix some corrupted json file from ~/.local/share/nvim/grapple/ or run `Grapple reset`
local Util = require("helpers.util")
return {
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-mini/mini.bufremove" },
    config = function()
      vim.api.nvim_set_hl(0, 'GrappleActive', { fg = "#333333", bg = "#eeeeee" })
      vim.api.nvim_set_hl(0, 'GrappleInactive', { fg = "#555555", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleNumberActive', { fg = "#af01db", bg = "#eeeeee" })
      vim.api.nvim_set_hl(0, 'GrappleNumberInctive', { fg = "#af01db", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleIcon', { fg = "#af01db", bg = "#ffffff" })
      vim.api.nvim_set_hl(0, 'GrappleActiveOpeningTriangle', { fg = "#cccccc", bg = "#eeeeee" })
      vim.api.nvim_set_hl(0, 'GrappleActiveClosingTriangle', { fg = "#eeeeee", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleActiveClosingTriangleLast', { fg = "#eeeeee", bg = "#ffffff" })
      vim.api.nvim_set_hl(0, 'GrappleInactiveOpeningTriangle', { fg = "#ffffff", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleInactiveClosingTriangle', { fg = "#cccccc", bg = "#eeeeee" })
      vim.api.nvim_set_hl(0, 'GrappleInactiveClosingTriangleLast', { fg = "#cccccc", bg = "#ffffff" })
      vim.api.nvim_set_hl(0, 'GrappleBg', { fg = "#ffffff", bg = "#555555" })

      vim.api.nvim_set_hl(0, 'TabLineFill', { fg = "#dddddd", bg = "#ffffff" })

      -- setting in opts does not work for win_opts.width
      require("grapple").setup(
        {
          scope = "git",          -- also try out "git_branch"
          icons = true,           -- setting to "true" requires "nvim-web-devicons"
          status = true,
          include_icon = false,   -- this has no effect, always set to true when checked in lualine.lua
          win_opts = {
            -- Can be fractional
            width = 140,
            height = 14,
          },
        })
    end,
    keys = function()
      local keys = {
        -- <leader>a stopped working
        { "<leader>ju",
          function()
            -- tag only if buffer is file, not neo-tree or terminal
            if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == '' and not Util.is_no_name_buf(0) then
              require("grapple").tag()
            end
          end,
          desc = "Tag a file"
        },
        { "<leader>jm",
          function()
            local Grapple = require("grapple")
            if Grapple.exists() then
              Grapple.untag()
              require("mini.bufremove").delete(0, true)
            end
          end,
          desc = "Untag a file"
        },
        { "<leader>jj", "<cmd>Grapple toggle_tags<cr>",     desc = "Toggle tags menu" },
        { "<S-l>",     "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
        { "<S-h>",     "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
      }

      for i = 1, 9 do
        table.insert(keys, {
          mode = (vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM ~= "iTerm.app") and { "i", "x", "n", "s" } or
          { "x", "n", "s" },
          (vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM ~= "iTerm.app") and string.format("<D-%s>", i) or
          string.format("<leader>%s", i),
          function()
            local Grapple = require("grapple")
            local tags = Grapple.tags()

            -- prevent switching to index bigger than number of tags
            if i > #tags then
              return
            end
            Grapple.select({ index = i })
          end,
          desc = string.format("Grapple select %s tag", i),
        })
      end
      return keys
    end,
  }
}
