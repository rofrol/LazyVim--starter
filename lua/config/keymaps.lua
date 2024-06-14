-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
-- https://vi.stackexchange.com/questions/39149/how-to-stop-neovim-from-yanking-text-on-pasting-over-selection/39907#39907
-- https://github.com/AndresMpa/mu-vim/blob/e6334b42775ce638f450faa665abb2772880293c/lua/mapping/navigation.lua#L47
local function map(mode, lhs, rhs, opts)
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

-- https://vi.stackexchange.com/questions/39149/how-to-stop-neovim-from-yanking-text-on-pasting-over-selection/39907#39907
-- https://vi.stackexchange.com/questions/25259/clipboard-is-reset-after-first-paste-in-visual-mode/25260#25260
-- https://github.com/disrupted/dotfiles/blob/1513aaa6d44654a2d8e0df6dd76078f15faa2460/.config/nvim/init.lua#L468
map("v", "p", "P")

-- copy and paste visual selection
-- https://stackoverflow.com/questions/731189/how-to-duplicate-a-selection-and-place-it-above-or-below-the-selection/14634666#14634666
map('v', '<C-p>', "y'>p")

-- delete other buffers except the current one and terminals
-- copilot
-- https://tech.serhatteker.com/post/2021-04/vim-delete-multiple-buffers/
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set
-- map("n", "<Leader>do", "<cmd>%bdelete|edit#|bdelete#<cr>")

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


-- I don't use it anymore as I use harpoon tabs
-- bufferline
-- map("n", "<Leader>mh", ":BufferLineMovePrev<CR>", {})
-- map("n", "<Leader>ml", ":BufferLineMoveNext<CR>", {})
-- map("n", "<Leader>mH", ":lua require'bufferline'.move_to(1)<CR>", {})
-- map("n", "<Leader>mL", ":lua require'bufferline'.move_to(-1)<CR>", {})

-- https://www.reddit.com/r/neovim/comments/16cso6u/comment/jzlcy3c/
if vim.fn.has("mac") == 1 and vim.env.TERM_PROGRAM ~= "iTerm.app" then
  -- unmap C-s on mac
  -- umap XXX may get error if there is no such mapping.
  -- map XXX <Nop> won't get error in that case and can disable vim's original(built in) command, such as d or s or c, while umap can't.
  -- https://vi.stackexchange.com/questions/16392/what-is-the-difference-between-unmap-and-mapping-to-nop/36833#36833
  map({ "i", "x", "n", "s" }, "<C-s>", "<Nop>")

  map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
end

-- mini.surround - wrap with backtick (`) and go to the end
map('n', '<leader>za', 'gsaiw`wl', { remap = true })
map('v', '<leader>za', 'gsa``>lll', { remap = true })

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
  ["<leader>"] = {
    w = {
      o = {
        close_all_non_visible_file_buffers,
        "close_all_non_visible_file_buffers"
      },
    },
    z = {
      z = {
        ':set number!<CR>:lua vim.o.laststatus = (vim.o.laststatus == 3 and 0 or 3) if vim.o.laststatus == 0 then vim.cmd("set noshowmode") else vim.cmd("set showmode") end<CR>:Gitsigns toggle_signs<CR>',
        -- does not work without below line
        "my zen mode"
      },
    },
    g = {
      m = {
        function()
          Run_command_and_close("git sync")
        end,
        "my git sync"
      },
    },
  }
}
-- on_load copied from lazy/LazyVim/lua/lazyvim/plugins/extras/coding/copilot-chat.lua
LazyVim.on_load("which-key.nvim", function()
  vim.schedule(function()
    require("which-key").register(which_key_table)
  end)
end)

-- Use alt+hjkl to move cursor
-- needs `macos_option_as_alt yes` in kitty.conf
-- https://www.reddit.com/r/neovim/comments/18ck6uq/comment/kcb9d8q/
-- vim.api.nvim_del_keymap('n', '<A-j>')
-- vim.api.nvim_del_keymap('v', '<A-j>')
-- vim.api.nvim_set_keymap('i', '<A-j>', '<Down>', { noremap = true })

-- vim.api.nvim_del_keymap('n', '<A-k>')
-- vim.api.nvim_del_keymap('v', '<A-k>')
-- vim.api.nvim_set_keymap('i', '<A-k>', '<Up>', { noremap = true })

-- vim.api.nvim_set_keymap('i', '<A-h>', '<Left>', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<A-l>', '<Right>', { noremap = true })


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
      require("which-key").register(
        {
          ["<leader>"] = {
            c = {
              h = {
                function()
                  vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
                end,
                "[lsp] toggle inlay hints"
              },
            },
          },
        }
      )
    end
  end,
})

-- https://stackoverflow.com/questions/4768088/automatic-new-line-and-indentation-in-vim-when-inside-braces
-- https://www.reddit.com/r/neovim/comments/hz9pwo/enable_smart_indent_on_curly_braces/
map('i', '{<CR>', '{<CR>}<Esc>O')
