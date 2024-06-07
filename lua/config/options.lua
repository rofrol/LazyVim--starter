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
