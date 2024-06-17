-- if true then return {} end
return {
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      scope = "git",          -- also try out "git_branch"
      icons = true,           -- setting to "true" requires "nvim-web-devicons"
      status = true,
      include_icon = false,   -- this has no effect, always set to true when checked in lualine.lua
    },
    config = function()
      vim.api.nvim_set_hl(0, 'GrappleActive', { fg = "#333333" })
      vim.api.nvim_set_hl(0, 'GrappleInactive', { fg = "#555555", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleNumberActive', { fg = "#af01db" })
      vim.api.nvim_set_hl(0, 'GrappleNumberInctive', { fg = "#af01db", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleIcon', { fg = "#af01db", bg = "#ffffff" })
      vim.api.nvim_set_hl(0, 'GrappleOpeningTriangle', { fg = "#ffffff", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleClosingTriangle', { fg = "#ffffff", bg = "#cccccc" })
      vim.api.nvim_set_hl(0, 'GrappleBg', { fg = "#ffffff", bg = "#cccccc" })

      vim.api.nvim_set_hl(0, 'TabLineFill', { fg = "#dddddd", bg = "#cccccc" })
    end,
    keys = function()
      local opts = { noremap = true, silent = true }
      local keys = {
        { "<leader>a", "<cmd>Grapple tag<cr>",          desc = "Tag a file" },
        { "<leader>ht", "<cmd>Grapple untag<cr>",          desc = "Untag a file" },
        { "<leader>j", "<cmd>Grapple toggle_tags<cr>",     desc = "Toggle tags menu" },
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
  },
}
