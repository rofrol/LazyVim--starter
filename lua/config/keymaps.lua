-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- https://vi.stackexchange.com/questions/39149/how-to-stop-neovim-from-yanking-text-on-pasting-over-selection/39907#39907
-- local function map(m, k, v)
--   vim.keymap.set(m, k, v, { silent = true })
-- end

-- https://github.com/AndresMpa/mu-vim/blob/e6334b42775ce638f450faa665abb2772880293c/lua/mapping/navigation.lua#L47
-- local map = vim.keymap.set

-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
local function map(mode, lhs, rhs, opts)
  -- Normal messages will not be given or added to the message history
  -- https://vi.stackexchange.com/questions/34346/silent-vs-silent-what-is-the-difference
  local options = { silent = true } -- remap = false is default alread
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- https://vi.stackexchange.com/questions/39149/how-to-stop-neovim-from-yanking-text-on-pasting-over-selection/39907#39907
-- https://vi.stackexchange.com/questions/25259/clipboard-is-reset-after-first-paste-in-visual-mode/25260#25260
-- https://github.com/disrupted/dotfiles/blob/1513aaa6d44654a2d8e0df6dd76078f15faa2460/.config/nvim/init.lua#L468
map("v", "p", "P")

map("n", "<Backspace>", "<cmd>noh<cr>")

-- delete other buffers
-- https://tech.serhatteker.com/post/2021-04/vim-delete-multiple-buffers/
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set
map("n", "<Leader>do", "<cmd>%bdelete|edit#|bdelete#<cr>")

-- I don't use it anymore as I use harpoon tabs
-- bufferline
map("n", "<Leader>mh", ":BufferLineMovePrev<CR>", {})
map("n", "<Leader>ml", ":BufferLineMoveNext<CR>", {})
map("n", "<Leader>mH", ":lua require'bufferline'.move_to(1)<CR>", {})
map("n", "<Leader>mL", ":lua require'bufferline'.move_to(-1)<CR>", {})
