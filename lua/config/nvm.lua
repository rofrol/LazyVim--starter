-- https://chatgpt.com/share/6872c999-c4d0-800b-a00f-8e94c7a2bb08
-- potrzebne gdy node instalowany przez nvm
local M = {}

function M.setup()
  -- Sprawdź czy NVM jest zainstalowane, inaczej będzie problem, że curl i git nie zainstalowane itp.
  local nvm_path = os.getenv("HOME") .. "/.nvm/nvm.sh"
  local nvm_file = io.open(nvm_path, "r")
  
  if not nvm_file then
    -- NVM nie jest zainstalowane - nie rób nic
    return
  end
  nvm_file:close()
  
  -- Wybierz odpowiednią powłokę (bash lub zsh)
  local shell = "zsh" -- Zmieniono na zsh zgodnie z user shell
  -- nvm install node
  -- nvm alias default node
  local cmd = shell .. [[ -c 'source "$HOME/.nvm/nvm.sh" && nvm use default > /dev/null 2>&1 && echo $PATH']]
  local handle = io.popen(cmd)
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result and result:match("%S") then
      -- Usuń końcowy \n i ustaw PATH w środowisku Neovim
      vim.env.PATH = result:gsub("%s+$", "")
    end
  end
end

return M
