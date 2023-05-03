-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false

-- delete other buffers
-- https://tech.serhatteker.com/post/2021-04/vim-delete-multiple-buffers/
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set
vim.keymap.set("n", "<Leader>do", "<cmd>%bdelete|edit#|bdelete#<cr>")
