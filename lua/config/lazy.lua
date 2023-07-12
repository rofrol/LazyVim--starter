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

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     vim.cmd("silent! lcd %:p:h")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   command = "silent! lcd %:p:h",
-- })

-- vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h" })

-- local generic_augroup = vim.api.nvim_create_augroup("config_generic", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = generic_augroup,
--   callback = function()
--     vim.cmd("silent! lcd %:p:h")
--     -- if vim.o.buftype ~= "terminal" then
--     --   vim.cmd("silent! lcd %:p:h")
--     -- end
--   end,
-- })
--
-- vim.api.nvim_command("command! Lcd lcd %:p:h")
-- vim.keymap.set("n", "<leader>p", ":lcd %:p:h<CR>:pwd<CR>", { desc = "Set local path to current file's path" })

-- local api = vim.api
-- local RunFile = api.nvim_create_augroup("RunFile", { clear = true })
--
-- api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   command = "lcd %:p:h",
--   group = RunFile,
-- })
--
-- vim.cmd([[
--   augroup AutoSaveOnInsertLeave
--     autocmd!
--     autocmd BufEnter * lcd %:p:h
--   augroup end
-- ]])

-- vim.api.nvim_create_user_command("S", function(opts)
--   vim.cmd({ cmd = "saveas", args = { opts.fargs[1] } })
-- end, {
--   nargs = 1,
--   -- complete = function(ArgLead, CmdLine, CursorPos)
--   --   -- return vim.fn.getcompletion(vim.fn.expand("%:h"), "file", 0)
--   --   -- return vim.fn.getcompletion(vim.fn.expand("%:p:h"), "file", 0)
--   --   -- return vim.fn.readdir(vim.fn.getcwd())
--   --   -- return vim.fn.expand("%:h")
--   --   -- return vim.fn.getcompletion(vim.fn.readdir(vim.fn.getcwd()), "file", 0)
--   --   return vim.fn.getcompletion(
--   --     vim.fn.split(
--   --       vim.fn.substitute(vim.fn.glob(vim.fn.expand("%:h") .. "/*"), vim.fn.expand("%:h") .. "/", "", "g"),
--   --       "\n"
--   --     )
--   --   )
--   --   -- return vim.fn.readdir(vim.fn.expand("%:h"))
--   -- end,
--   complete = complete,
--   bang = true,
-- })

local function join_file_parent(lead)
  local parent = vim.fn.expand("%:p:h")
  return parent .. (parent == "/" and "" or "/") .. lead
end

-- https://app.element.io/#/room/#neovim:matrix.org/$NRq6DdJlrJWk8dIQUvj18bD8EymugPW0Cv44vOAEw-A
local function complete(lead)
  local parent = vim.fn.expand("%:p:h")
  return vim.tbl_map(function(path)
    return vim.fn.fnamemodify(path, ":p"):gsub("^" .. vim.pesc(parent) .. "/?", "")
  end, vim.fn.getcompletion(join_file_parent(lead), "file"))
  -- neovim master: end, vim.fn.getcompletion(vim.fs.joinpath(vim.fn.expand("%:p:h"), lead), "file"))
end

vim.api.nvim_create_user_command("S", function(opts)
  vim.cmd({ cmd = "sav", args = { vim.fn.fnameescape(join_file_parent(opts.fargs[1])) } })
end, {
  nargs = "?",
  -- complete = complete,
  complete = "file",
})

-- https://github.com/mmai/dotfiles/blob/056d58a0d113fae80fc38b351025476c665bb4b6/.config/classicNvim/lua/user/keymaps.lua#L20
vim.cmd([[
  " Expand %% to path of current buffer in command mode.
  cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])

-- https://github.com/wyntau/dotfiles/blob/eeee2137befa11e74d8fc7c3c2060a7b4e4f195f/nvim/lua/basic.lua#L72C1-L76C4
-- Open help in a vertical split instead of the default horizontal split
vim.cmd([[
  cabbrev h <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<cr>
  cabbrev help <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<cr>
]])

-- vim.cmd([[
-- cabbrev <expr> sav (getcmdtype()==':' && getcmdpos()==4 ? 'sav ' . expand('%:h').'/' : 'sav')
-- ]])

-- vim.keymap.set("c", "S", function()
--   local lead = vim.fn.expand("%:h")
--   return "sav " .. vim.fn.fnameescape(lead) .. (lead ~= "/" and "/" or "")
-- end, { expr = true })
--
-- local bs = vim.api.nvim_replace_termcodes("<bs>", true, false, true)
--
-- vim.keymap.set("c", "R", function()
--   local lead = vim.fn.expand("%:h")
--   vim.schedule(function()
--     if vim.fn.getcmdline():match(" $") then
--       vim.api.nvim_feedkeys(bs, "n", false)
--     end
--   end)
--   return "sav " .. vim.fn.fnameescape(lead) .. (lead ~= "/" and "/" or "")
-- end, { expr = true })

-- when doing :sav<Space> it will expand to to :sav current_dir/
-- https://matrix.to/#/!cylwlNXSwagQmZSkzs:matrix.org/$f-HOgoPE976yY8TjrMYFZQ14b9kpcjaZfdKIUaoCJ6Q?via=matrix.org&via=gitter.im&via=tchncs.de
vim.keymap.set("c", "<space>", function()
  if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "sav" then
    return " " .. vim.fn.expand("%:h") .. "/"
  else
    return "<space>"
  end
end, { expr = true })
