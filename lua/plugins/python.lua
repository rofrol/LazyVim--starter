return {
  {
    "linux-cultist/venv-selector.nvim",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Auto select virtualenv Nvim open",
        pattern = "*",
        callback = function()
          -- https://github.com/igorgue/dotnvim/blob/c8d8b8f03507bd14c8b2243510a285ec1ffe7cd1/lua/plugins/extras/lang/python.lua#L94
          -- https://github.com/S1M0N38/dots/blob/0a0eee8046ac449b5954e33b8d8c9991eacb2c00/config/LazyVim/lua/plugins/projects.lua#L29
          -- https://github.com/MasouShizuka/config/blob/8fa76270a901bd2bcb820708162c3f1f2e05e565/neovim/lua/plugins/programming_languages_support/python.lua#L24
          -- https://github.com/Den4ick240/nvim/blob/15ef962e12f47ff8962fdb54a7916de78b19ec11/lua/plugins/venv-selector.lua#L20
          require("venv-selector").retrieve_from_cache()
        end,
        once = true,
      })

      return true
    end,
  },
}
