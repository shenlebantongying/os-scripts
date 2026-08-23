local wezterm = require 'wezterm'

local is_MacOS = function()
    return wezterm.target_triple=="aarch64-apple-darwin"
end

local MacOS = is_MacOS()
local Linux = not MacOS

local config = {}

config.font = wezterm.font_with_fallback {
  'Annotation Mono',
  'Intel One Mono',
  'Cascadia Mono',
  'Ubuntu Mono',
}

if (Linux) then
  config.font_size = 12.0
else
  config.font_size = 12.0
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  config.window_frame = {
    font_size=12.0
  }

  config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
end

config.color_scheme = 'Bamboo Light'
-- config.text_min_contrast_ratio = 4.5 nightly

config.enable_scroll_bar = true

config.window_padding = {
  left = '0.2cell',
  right = '1cell',
  top = '0.1cell',
  bottom = '0.2cell',
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
