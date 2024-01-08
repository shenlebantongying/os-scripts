function is_macOS()
  local handle = io.popen('uname')
  local result = handle:read('*a')
  handle:close()
  return result == 'Darwin\n'
end

local wezterm = require 'wezterm'
local config = {}


local macOS = is_macOS()

config.color_scheme = 'Modus-Operandi'

config.colors = {
  cursor_fg = 'white'
}

config.font = wezterm.font 'Intel One Mono'

if (is_macOS) then
  config.font_size = 14.0
else 
  config.font_size = 10.0
end

config.enable_scroll_bar = true

config.window_frame = {
  font = wezterm.font { family = 'Intel One Mono', weight = 'Bold' },
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0, 
  bottom = 0,
}

return config
