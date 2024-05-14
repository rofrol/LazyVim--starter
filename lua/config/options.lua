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
-- ccmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
-- ccmd("InsertLeave", { command = "set relativenumber", pattern = "*" })

-- not needed when toggleterm options: start_in_insert = true, persist_mode = false
-- https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane/43781#43781
-- https://github.com/BrunoKrugel/dotfiles/blob/bb3e0508b8356e4d41eae5f3ad45d040d5f0935c/lua/custom/utils/autocmd.lua#L352
-- https://github.com/petobens/dotfiles/blob/ad877a4b9b2fb7b356704aecb3f22aef0a178b54/nvim/lua/plugin-config/toggleterm_config.lua#L20
-- https://www.reddit.com/r/neovim/comments/xzfbm8/comment/irm3mem/
-- not using termtoggle https://www.reddit.com/r/neovim/comments/vqlaqe/comment/ier99yu/
-- ccmd({ "TermOpen", "BufEnter" }, {
--     pattern = "*",
--     callback = function()
--         if vim.opt.buftype:get() == "terminal" then
--             vim.cmd(":startinsert")
--         end
--     end
-- })

-- works even if toggleterm option persist_mode = false
-- https://vi.stackexchange.com/questions/22307/neovim-go-into-insert-mode-when-clicking-in-a-terminal-in-a-pane/22327#22327
vim.api.nvim_command "augroup terminal_setup | au!"
vim.api.nvim_command "autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i"
vim.api.nvim_command "augroup end"

function Run_command_and_close(command)
  vim.cmd('botright new')
  local bufnr = vim.api.nvim_get_current_buf()
  vim.fn.termopen(command, {on_exit = function(_, exit_status)
    if exit_status == 0 then
      vim.api.nvim_buf_delete(bufnr, {force = true})
    end
  end})
end

vim.api.nvim_set_keymap('n', '<F5>', [[<Cmd>lua Run_command_and_close('git sync')<CR>]], {noremap = true})
