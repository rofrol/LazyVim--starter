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
  -- noremap prevents recursive mapping, meaning that the keybinding
  -- will not trigger other mappings. It ensures that the key sequence executes
  -- only the assigned command without any further remapping.
  local options = { silent = true } -- remap = false is default already
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

-- delete other buffers except the current one and terminals
-- copilot
-- https://tech.serhatteker.com/post/2021-04/vim-delete-multiple-buffers/
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set
-- map("n", "<Leader>do", "<cmd>%bdelete|edit#|bdelete#<cr>")

-- Function to close all buffers except current buffer and terminal buffers
function _G.close_all_buffers_except_current_and_terminals()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()
  local closed_bufs = 0

  for _, buf in ipairs(bufs) do
    if buf ~= current_buf and vim.api.nvim_buf_get_option(buf, 'buftype') ~= 'terminal' then
      vim.api.nvim_buf_delete(buf, { force = true })
      closed_bufs = closed_bufs + 1
    end
  end

  print(closed_bufs .. " buffer(s) closed")
end

-- Keybinding
vim.api.nvim_set_keymap('n', '<leader>do', ':lua close_all_buffers_except_current_and_terminals()<CR>', { noremap = true, silent = true })


-- I don't use it anymore as I use harpoon tabs
-- bufferline
map("n", "<Leader>mh", ":BufferLineMovePrev<CR>", {})
map("n", "<Leader>ml", ":BufferLineMoveNext<CR>", {})
map("n", "<Leader>mH", ":lua require'bufferline'.move_to(1)<CR>", {})
map("n", "<Leader>mL", ":lua require'bufferline'.move_to(-1)<CR>", {})

-- https://www.reddit.com/r/neovim/comments/16cso6u/comment/jzlcy3c/
if vim.fn.has("mac") == 1 then
  -- unmap C-s on mac
  -- umap XXX may get error if there is no such mapping.
  -- map XXX <Nop> won't get error in that case and can disable vim's original(built in) command, such as d or s or c, while umap can't.
  -- https://vi.stackexchange.com/questions/16392/what-is-the-difference-between-unmap-and-mapping-to-nop/36833#36833
  vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<Nop>")

  vim.keymap.set({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
end

map('n', '<leader>sp', ':setlocal spell spelllang=pl<CR>:setlocal spellfile=$HOME/.config/nvim/spell/pl.utf-8.add<CR>:echo "Spelling set to Polish"<CR>')
map('n', '<leader>se', ':setlocal spell spelllang=en_us<CR>:setlocal spellfile=$HOME/.config/nvim/spell/en.utf-8.add<CR>:echo "Spelling set to English (US)"<CR>')

map('n', '<leader>a', 'gsaiw`wl')
map('v', '<leader>a', 'gsa``>lll')
