package.path = "./lua/?/init.lua;./lua/?.lua"

---Write content to file.
---@param str string content of file.
---@param file_name string path of file.
local function write(str, file_name)
  print("[write]" .. file_name)
  local file = io.open(file_name, "w")
  file:write(str)
  file:close()
end

local extras = {
  kitty = "conf",
  alacritty = "yml",
  iterm = "itermcolors",
  konsole = "colorscheme",
  tmux = "tmux"
}

for _, style in ipairs({"dark", "dimmed", "light", "dark_default", "light_default"}) do
  local config = {theme_style = style, transform_colors = true}
  for extra, ext in pairs(extras) do
    local plugin = require("github-theme.extra." .. extra)
    local file_name = "extras/" .. extra .. "/" .. style .. "." .. ext
    write(plugin[extra](config), file_name)
  end
end
