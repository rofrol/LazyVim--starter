return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- needed: autoformat of odin files will behave strange when used with ols
      odin = { "odinfmt" },
    },
  },
}
