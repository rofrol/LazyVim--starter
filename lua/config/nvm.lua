-- https://chatgpt.com/share/6872c999-c4d0-800b-a00f-8e94c7a2bb08
-- potrzebne gdy node instalowany przez nvm
local M = {}

function M.setup()
  -- Wybierz odpowiednią powłokę (bash lub zsh)
  local shell = "bash"
  -- nvm install node
  -- nvm alias default node
  local cmd = shell .. [[ -c 'source "$HOME/.nvm/nvm.sh" && nvm use default > /dev/null && echo $PATH']]
  local handle = io.popen(cmd)
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result then
      -- Usuń końcowy \n i ustaw PATH w środowisku Neovim
      vim.env.PATH = result:gsub("%s+$", "")
    end
  end
end

return M
