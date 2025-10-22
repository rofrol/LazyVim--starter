-- https://github.com/LazyVim/LazyVim/discussions/2248
-- inserts enter correctly after typing {}

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,   -- smart indenting with treesitter
    map_cr = true,     -- handles <CR>
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup(opts)

    npairs.remove_rule("'")
    npairs.remove_rule('"')

    -- remove standard pairs that interfere
    npairs.remove_rule("{")
    npairs.remove_rule("[")
    npairs.remove_rule("(")

    local function closing_bracket_after_enter(open_char, close_char)
      return Rule(open_char, "")
        :with_pair(cond.none())        -- don't insert closing char immediately
        :with_move(cond.none())        -- don't jump over closing char
        :with_del(cond.none())         -- don't automatically delete closing char
        :with_cr(function(options)
          -- Check if we're at the end of line and the previous character matches
          return options.prev_char == open_char and options.next_char == ''
        end)
        :replace_map_cr(function()
          -- Sequence that:
          -- 1. <C-g>u - break undo sequence
          -- 2. <CR> - new line with auto-indent
          -- 3. close_char - insert closing character
          -- 4. <CR> - another new line
          -- 5. <C-c> - switch to normal mode
          -- 6. k - move up (to the line with closing char)
          -- 7. O - open new line ABOVE the current line and enter insert mode
          return "<C-g>u<CR>" .. close_char .. "<CR><C-c>kO"
        end)
    end

    npairs.add_rules({
      closing_bracket_after_enter("{", "}"),
      closing_bracket_after_enter("[", "]"),
      closing_bracket_after_enter("(", ")"),
    })
  end,
}

