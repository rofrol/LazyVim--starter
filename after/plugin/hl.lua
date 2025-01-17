-- https://github.com/TheCrabilia/dotfiles/blob/9fbc56a03ecd1eac49d245cab411d5e04686ff88/nvim/.config/nvim/after/plugin/hl.lua#L2
-- Disable italic for all highlight groups
for name, opts in pairs(vim.api.nvim_get_hl(0, {})) do
	vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", opts, { italic = false }))
end
