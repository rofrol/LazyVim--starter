local M = {}

-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
-- https://vi.stackexchange.com/questions/39149/how-to-stop-neovim-from-yanking-text-on-pasting-over-selection/39907#39907
-- https://github.com/AndresMpa/mu-vim/blob/e6334b42775ce638f450faa665abb2772880293c/lua/mapping/navigation.lua#L47
function M.map(mode, lhs, rhs, opts)
  -- Normal messages will not be given or added to the message history
  -- https://vi.stackexchange.com/questions/34346/silent-vs-silent-what-is-the-difference
  -- noremap prevents recursive mapping, meaning that the keybinding
  -- will not trigger other mappings. It ensures that the key sequence executes
  -- only the assigned command without any further remapping.
  local options = { silent = true, noremap = true }
  -- remap = false is default already for vim.keymap.set
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  -- this needs `noremap: false` to work: map('n', '<leader>za', 'gsaiw`wl')
  vim.keymap.set(mode, lhs, rhs, options)
  -- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M