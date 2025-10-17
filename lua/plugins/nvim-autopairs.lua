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

    local function closing_bracket_after_enter(opening_char, closing_char)
      return Rule(opening_char, "")
        :with_pair(cond.none())
        :with_move(cond.none())
        :with_del(cond.none())
        :only_cr(cond.done())
        :replace_map_cr(function()
          return "<C-g>u<CR>" .. closing_char .. "<CR><C-c>kO"
        end)
    end

    npairs.add_rules({
      closing_bracket_after_enter("{", "}"),
      closing_bracket_after_enter("[", "]"),
      closing_bracket_after_enter("(", ")"),
    })
  end,
}

