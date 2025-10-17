-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("helpers.util")

-- https://vi.stackexchange.com/questions/39149/how-to-stop-neovim-from-yanking-text-on-pasting-over-selection/39907#39907
-- https://vi.stackexchange.com/questions/25259/clipboard-is-reset-after-first-paste-in-visual-mode/25260#25260
-- https://github.com/disrupted/dotfiles/blob/1513aaa6d44654a2d8e0df6dd76078f15faa2460/.config/nvim/init.lua#L468
Util.map("v", "p", "P")

-- copy and paste visual selection
-- https://stackoverflow.com/questions/731189/how-to-duplicate-a-selection-and-place-it-above-or-below-the-selection/14634666#14634666
Util.map('v', '<C-p>', "y'>p")

-- delete other buffers except the current one and terminals
-- copilot
-- https://tech.serhatteker.com/post/2021-04/vim-delete-multiple-buffers/
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set
-- Util.map("n", "<Leader>do", "<cmd>%bdelete|edit#|bdelete#<cr>")

local function close_all_non_visible_file_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  local visible_bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    visible_bufs[vim.api.nvim_win_get_buf(win)] = true
  end

  local bufs = vim.api.nvim_list_bufs()
  local closed_bufs = 0

  for _, buf in ipairs(bufs) do
    if buf ~= current_buf and not visible_bufs[buf] and vim.api.nvim_buf_get_option(buf, 'buftype') == '' then
      vim.api.nvim_buf_delete(buf, { force = true })
      closed_bufs = closed_bufs + 1
    end
  end

  print(closed_bufs .. " non-visible file buffer(s) closed")
end


-- I don't use it anymore as I use grapple tabs
-- bufferline
-- Util.map("n", "<Leader>mh", ":BufferLineMovePrev<CR>", {})
-- Util.map("n", "<Leader>ml", ":BufferLineMoveNext<CR>", {})
-- Util.map("n", "<Leader>mH", ":lua require'bufferline'.move_to(1)<CR>", {})
-- Util.map("n", "<Leader>mL", ":lua require'bufferline'.move_to(-1)<CR>", {})

-- https://www.reddit.com/r/neovim/comments/16cso6u/comment/jzlcy3c/
if vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM ~= "iTerm.app" then
  -- unmap C-s on mac
  -- umap XXX may get error if there is no such mapping.
  -- map XXX <Nop> won't get error in that case and can disable vim's original(built in) command, such as d or s or c, while umap can't.
  -- https://vi.stackexchange.com/questions/16392/what-is-the-difference-between-unmap-and-mapping-to-nop/36833#36833
  -- Util.map({ "i", "x", "n", "s" }, "<C-s>", "<Nop>")
  vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")

  Util.map({ "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
  Util.map("i", "<D-s>", "<cmd>w<cr><esc>l", { desc = "Save file" })
  -- simulate emacs C-x C-s to save
  Util.map({ "x", "n", "s" }, "<D-x><D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
  Util.map("i", "<D-x>", "<esc>", { desc = "Save file" })
end

function Run_command_and_close(command)
  vim.cmd('botright new')
  vim.cmd('resize 5')
  local bufnr = vim.api.nvim_get_current_buf()
  vim.fn.termopen(command, {
    on_exit = function(_, exit_status)
      if exit_status == 0 then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end
  })
end

local which_key_table = {
  {
    "<leader>gm",
    function()
      Run_command_and_close("git sync")
    end,
    desc = "my git sync"
  },
  { "<leader>wo", close_all_non_visible_file_buffers, desc = "close_all_non_visible_file_buffers" },
  { "<leader>zz", Util.toggle_zen_mode,               desc = "my zen mode" },
}
-- on_load copied from lazy/LazyVim/lua/lazyvim/plugins/extras/coding/copilot-chat.lua
LazyVim.on_load("which-key.nvim", function()
  vim.schedule(function()
    require("which-key").add(which_key_table)
  end)
end)

-- Use alt+hjkl to move cursor
-- needs `macos_option_as_alt yes` in kitty.conf
-- https://www.reddit.com/r/neovim/comments/18ck6uq/comment/kcb9d8q/
-- vim.api.nvim_del_keymap('n', '<A-j>')
-- vim.api.nvim_del_keymap('v', '<A-j>')
-- Util.map('i', '<A-j>', '<Down>')

-- vim.api.nvim_del_keymap('n', '<A-k>')
-- vim.api.nvim_del_keymap('v', '<A-k>')
-- Util.map('i', '<A-k>', '<Up>')

-- Util.map('i', '<A-h>', '<Left>')
-- Util.map('i', '<A-l>', '<Right>')


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if not client then
      return
    end

    -- I used client.server_capabilities.inlayHintProvider instead off
    -- client.supports_method('textDocument/inlayHint') and it was the same.
    -- https://github.com/neovim/neovim/issues/24183#issuecomment-1613193304
    if client.server_capabilities.inlayHintProvider then
      local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      local inlay_hints_group = vim.api.nvim_create_augroup('rofrol/toggle_inlay_hints', { clear = false })

      -- https://github.com/MariaSolOs/dotfiles/blob/597848ee02e6500454d6b5817a1ed0928e80dafa/.config/nvim/lua/lsp.lua#L105-L119
      vim.api.nvim_create_autocmd('InsertEnter', {
        group = inlay_hints_group,
        desc = 'Enable inlay hints',
        buffer = bufnr,
        callback = function()
          vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

          -- create a single use autocommand to turn the inlay hints back on
          -- when leaving insert mode
          -- https://github.com/AstroNvim/astrocommunity/blob/c12216c538088c5ec892b1c3cf616ca882a7d22e/lua/astrocommunity/recipes/astrolsp-no-insert-inlay-hints/init.lua#L20
          vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = bufnr,
            once = true,
            callback = function() vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end,
          })
        end,
      })

      -- https://github.com/nix-community/kickstart-nix.nvim/blob/758ca4ef427ca1444d530b0e32dd6add32734181/nvim/plugin/autocommands.lua#L100
      require("which-key").add(
        {
          {
            "<leader>ch",
            function()
              vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
            end,
            desc = "[lsp] toggle inlay hints"
          },
        }
      )
    end
  end,
})

-- https://stackoverflow.com/questions/4768088/automatic-new-line-and-indentation-in-vim-when-inside-braces
-- https://www.reddit.com/r/neovim/comments/hz9pwo/enable_smart_indent_on_curly_braces/
-- vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O')

local function insert_datetime()
  vim.cmd('normal! G')
  local datetime = "## " .. os.date("%Y-%m-%d %H:%M")
  vim.api.nvim_put({ '', datetime, '', '' }, 'l', true, true)
  vim.cmd('normal! 3j')
  vim.cmd('startinsert')
end

Util.map({'n','i'}, '<C-d>', function() insert_datetime() end, { desc = 'Insert date and time' })

-- Odin

-- https://yeripratama.com/blog/customizing-nvim-telescope/

local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function get_odin_root()
  return normalize_path(vim.fn.system("odin root"))
end

local function path_display(_, path)
  local normalized_path = normalize_path(path)
  local odin_root = get_odin_root()

  if normalized_path:sub(1, #odin_root) == odin_root then
    normalized_path = normalized_path:sub(#odin_root + 1)
  end

  local filename = normalized_path:match("[^/]+$") or normalized_path
  local stripped_path = normalized_path:sub(1, -(#filename + 1))

  if filename == stripped_path or stripped_path == "" then
    return filename
  end
  return string.format("%s ~ %s", filename, stripped_path)
end
-- _G.path_display = path_display
-- _G.get_odin_root = get_odin_root

local odin_root = vim.fn.system("odin root")
local config = {
    -- https://stackoverflow.com/questions/71809098/how-to-include-specific-hidden-file-folder-in-search-result-when-using-telescope/72545476#72545476
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt
    file_ignore_patterns = {"%_private.odin"},
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        preview_height = 0.4,     -- preview window, results will take the rest if preview_cutoff = 0
        preview_cutoff = 0,       -- minimal height to show preview
        height = 0.9,             -- height of whole telescope window
        width = 0.9,              -- width of whole telescope window
        mirror = true,            -- search input on top
      },
      prompt_position = "top",
    },
    path_display = path_display,
    prompt_title = "Odin Standard Library"
  }

-- local builtin = require('telescope.builtin')

-- vim.keymap.set('n', '<leader>osc', function()
--   builtin.live_grep(vim.tbl_deep_extend("force", config, {
--     search_dirs = { odin_root .. "core" }
--   }))
-- end, { desc = "Search core of Odin Standard Library" })

-- vim.keymap.set('n', '<leader>osb', function()
--   builtin.live_grep(vim.tbl_deep_extend("force", config, {
--     search_dirs = { odin_root .. "base" }
--   }))
-- end, { desc = "Search base of Odin Standard Library" })

-- vim.keymap.set('n', '<leader>osv', function()
--   builtin.live_grep(vim.tbl_deep_extend("force", config, {
--     search_dirs = { odin_root .. "vendor" }
--   }))
-- end, { desc = "Search vendor of Odin Standard Library" })

