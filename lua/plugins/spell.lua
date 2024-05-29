-- https://github.com/datwaft/nvim.conf/blob/7931ab3d9be0fb2feab57b3f28b70f55955f8029/init.lua#L53
-- vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""

-- neovim needs to have /spell/techspeak processed by mkspell
-- otherwise it will ask to download spell file for techspeak
-- then we can use techspeak.utf-8.add
local function ensure_no_downloading_for_custom_spellfile(file)
  if not vim.uv.fs_stat(file) then
    vim.fn.writefile({}, file)           -- Create an empty file if it doesn't exist
    vim.cmd("silent! mkspell! " .. file) -- Generate the .spl file without showing info
  end
end

local function spell_multiple()
  local techspeak_spellfile = vim.fn.stdpath("config") .. "/spell/techspeak"
  ensure_no_downloading_for_custom_spellfile(techspeak_spellfile)

  vim.opt.spelllang = { "techspeak", "en_us", "pl" }
  vim.opt.spellfile = {
    techspeak_spellfile .. ".utf-8.add",
    vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
    vim.fn.stdpath("config") .. "/spell/pl.utf-8.add",
  }
  print("Spelling set to techspeak, English (US), Polish");
end
spell_multiple()

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>o"] = {
          name = "Spell",
          p = {
            function()
              vim.bo.spelllang = "pl"
              vim.bo.spellfile = vim.fn.stdpath("config") .. "/spell/pl.utf-8.add"
              print("Spelling set to Polish");
            end,
            "Spelling set to Polish"
          },
          e = {
            function()
              vim.bo.spelllang = "en_us"
              vim.bo.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
              print("Spelling set to English (US)");
            end,
            "Spelling set to English (US)"
          },
          m = {
            spell_multiple,
            "Spelling set to techspeak, Polish, English (US)"
          },
        },
      },
    },
  },
}
