-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.swapfile = false
opt.relativenumber = false
opt.wrap = true
vim.g.maplocalleader = [[;]]
opt.shell = "zsh --login"

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

function Run_command_and_close(command)
  vim.cmd('botright new')
  vim.fn.termopen(command, {on_exit = function(_, exit_status)
    if exit_status == 0 then
      vim.cmd('bdelete!')
    end
  end})
end

vim.api.nvim_set_keymap('n', '<F5>', [[<Cmd>lua Run_command_and_close('git sync')<CR>]], {noremap = true})
