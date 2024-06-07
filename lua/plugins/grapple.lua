if true then return {} end
return {
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        scope = "git", -- also try out "git_branch"
        icons = true, -- setting to "true" requires "nvim-web-devicons"
        status = true,
    },
    keys = {
        { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
        { "<leader>j", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
        { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle" },

        { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
        { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
        { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
        { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

        { "<S-l>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
        { "<S-h>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },

    },
  },
}
