-- based on https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ols.lua
-- Install https://github.com/DanielGavin/ols
-- https://odin-lang.org/showcase/ols/
-- gd go to definition
-- K hover
-- gr to show references
-- <Leader>ss to show symbols or sS to show workspace symbols
-- <Leader>cr to rename
-- <Leader>cS to toggle LSP references/definitions/...
-- more: <Leader>sk and search lsp
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ols = {
          cmd = { "ols" },
          filetypes = { "odin" },
          root_dir = require("lspconfig.util").root_pattern('ols.json', '.git', '*.odin'),
        },
      },
    },
  },
}
