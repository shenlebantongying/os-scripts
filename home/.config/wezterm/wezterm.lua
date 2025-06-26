local is_Linux = function()
  local handle = io.popen('uname')
  if (handle ~= nil) then
    local result = handle:read('*a') == "Linux\n"
    handle:close()
    return result
  else
    os.exit(1)
  end
end

local Linux = is_Linux()

local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font_with_fallback {
  'Intel One Mono',
  'Cascadia Mono',
  'Ubuntu Mono',
}

if (Linux) then
  config.font_size = 12.0
else
  config.font_size = 15.0
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  config.window_frame = {
    font_size=14.0
  }
end

config.color_scheme = 'Builtin Solarized Light'
config.colors = {
  cursor_fg = 'white'
}

config.enable_scroll_bar = true


config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- DISABLE copy on selection
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action.Nop,
  },
}

config.scrollback_lines=6000

return config
