-- https://github.com/LazyVim/LazyVim/discussions/2248
-- inserts enter correctly after typing {}
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,   -- smart indenti with treesitter
    map_cr = true,     -- smart enter
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)
  end,
}
