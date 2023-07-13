local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },

    -- copilot multi-line suggestion accept works out of-the-box with Entering
    -- https://github.com/zbirenbaum/copilot-cmp/issues/45#issuecomment-1455134141
    { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.util.project" },
    { import = "lazyvim.plugins.extras.editor.flash" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  --install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = "Yellow" })
    vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = "#ffffff" })
    -- vim.api.nvim_set_hl(0, "@lsp.mod.readonly", { italic = true })
  end,
})

-- https://github.com/mmai/dotfiles/blob/056d58a0d113fae80fc38b351025476c665bb4b6/.config/classicNvim/lua/user/keymaps.lua#L20
vim.cmd([[
  " Expand %% to path of current buffer in command mode.
  cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])

-- when doing :sav<Space> it will expand to to :sav current_dir/
-- https://matrix.to/#/!cylwlNXSwagQmZSkzs:matrix.org/$f-HOgoPE976yY8TjrMYFZQ14b9kpcjaZfdKIUaoCJ6Q?via=matrix.org&via=gitter.im&via=tchncs.de
vim.keymap.set("c", " ", function()
  if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "sav" then
    local lead = vim.fn.expand("%:h")
    return " " .. vim.fn.fnameescape(lead) .. "/"
  else
    return " "
  end
end, {
  expr = true,
  replace_keycodes = false, -- path might have keycodes
})
