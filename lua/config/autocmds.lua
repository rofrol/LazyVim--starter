-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- override default LazyVim options for Markdown files
-- FileType https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/config/autocmds.lua#L75
-- vim.wo.conceallevel https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/plugins/extras/lang/tex.lua#L35
-- https://github.com/ooloth/dotfiles/blob/6c3848ef4a13fe4be01e48108a883f4404d2f65e/config/nvim-lazyvim/lua/config/autocmds.lua#L26
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup("markdown_conceal", { clear = true }),
  pattern = { 'markdown', 'json' },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.number = false
  end,
})

-- does not work
-- disable autoformat for markdown files as there is some truncation issue
-- https://www.lazyvim.org/configuration/tips#disable-autoformat-for-some-buffers
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    vim.b.autoformat = false
  end,
})

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
