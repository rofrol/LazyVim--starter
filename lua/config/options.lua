-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.swapfile = false
opt.relativenumber = false
opt.wrap = true
vim.g.maplocalleader = [[;]]

-- https://github.com/TristanLeclair/nvim/blob/8a6d3dfcdf01245b8fe34c5d9b1afffcfb063f56/lua/tlecla/options.lua#L46C1-L49C61
-- https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane/22956#22956
local ccmd = vim.api.nvim_create_autocmd
ccmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
ccmd("InsertLeave", { command = "set relativenumber", pattern = "*" })

-- https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane/43781#43781
ccmd({ "TermOpen", "BufEnter" }, {
    pattern = "*",
    callback = function()
        if vim.opt.buftype:get() == "terminal" then
            vim.cmd(":startinsert")
        end
    end
})
