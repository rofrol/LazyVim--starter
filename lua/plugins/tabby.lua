if true then return {} end
return {
  {
    'nanozuki/tabby.nvim',
    -- event = 'VimEnter', -- if you want lazy load, see below
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.o.showtabline = 2
      vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
      vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
      -- move current tab to previous position
      vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
      -- move current tab to next position
      vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>1", "1gt", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>2", "2gt", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>3", "3gt", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>4", "4gt", { noremap = true })
    end,
  }
}
