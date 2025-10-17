return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,   -- włącz inteligentne wcięcia przez treesitter
    map_cr = true,     -- smart enter
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)
  end,
}
