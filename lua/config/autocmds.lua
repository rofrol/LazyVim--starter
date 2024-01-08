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
