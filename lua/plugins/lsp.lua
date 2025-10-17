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
      setup = {
        require('lspconfig').ols.setup {
          -- needs to be full path, :LspLog shows that ols cannot find builtin folder.
          -- cmd = { vim.fn.exepath("ols") },
          -- ols newer than from mason
          -- odifmt needs `odinfmt.json` in project directory https://github.com/DanielGavin/ols?tab=readme-ov-file#odinfmt-configurations
          cmd = { vim.fn.exepath(vim.fn.expand("$HOME/personal_projects/odin/vendor/ols/ols")) },
          filetypes = { "odin" },
          root_dir = require("lspconfig.util").root_pattern('ols.json', '.git', '*.odin'),
          on_attach = function(client)
            -- Disable lsp completion, because it works incorrectly.
            -- i.e. typing rl. will show all
            -- but typing rl.Draw will not show DrawRectangleV
            client.server_capabilities.completionProvider = nil
          end,
        }
      },
    },
  },
}
