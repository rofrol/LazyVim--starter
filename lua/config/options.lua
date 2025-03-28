-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.swapfile = false
opt.relativenumber = false
opt.wrap = true
vim.g.maplocalleader = [[;]]
if vim.fn.has("mac") == 1 then
  LazyVim.terminal.setup("zsh")
else
  LazyVim.terminal.setup("bash")
end

-- HIGHLIGHTING FIX
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#d79921", sp = "#d79921", underline = true })
vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#d79921", sp = "#d79921", underline = true })
vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#d79921", sp = "#d79921", underline = true })

-- local editor_layout = require("builtin.utils.layout").editor
-- local MAX_NAME_LENGTH = editor_layout.width(0.334, 15, 80)

-- does not work settings this in autocmds.lua
-- https://vi.stackexchange.com/questions/29552/how-to-modify-only-the-background-colour-of-a-colourscheme-in-neovim-using-lua/29557#29557
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    if vim.o.background == 'light' then
      -- vim.api.nvim_set_hl(0, 'Normal', { bg = "#ffffff" })
      vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = "#ffffff" })
    end
  end,
})

vim.g.myzenmode = false

-- line heightlight only for number column?
-- https://www.reddit.com/r/neovim/comments/12ufetq/comment/jh85j9c/
vim.opt.cursorlineopt='number'
