-- -*- lua-indent-level: 2 -*-

hyper  = {"control", "option"}

function get_screen_h()
  local s = hs.screen.mainScreen()
  local sf = s:frame()
  return sf.h
end


hs.hotkey.bind(
  hyper, "up", "Tall",
  function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max_h = get_screen_h()
    f.h=max_h
    f.y=0    
    win:setFrame(f)
  end
)

hs.hotkey.bind(
  hyper, "down", "Half",
  function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max_h = get_screen_h()
    f.h=max_h*2/3
    f.y=max_h*1/6 
    win:setFrame(f)
  end
)

hs.hotkey.bind(
  hyper, "right", "Right",
  function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local s = hs.screen.mainScreen()
    local sf = s:frame()
    
    f.x=sf.x+sf.w-f.w
    f.y=0
    win:setFrame(f)
  end
)

hs.hotkey.bind(
  hyper, "left", "Left",
  function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local s = hs.screen.mainScreen()
    local sf = s:frame()
    
    f.x=sf.x
    f.y=0
    win:setFrame(f)
  end
)

function volumeAdj(step)
  local device = hs.audiodevice.defaultOutputDevice()
  local volprev = math.floor(device:outputVolume()+0.5)

  if volprev<1.0 and step<0 then
    return
  end
  
  device:setOutputVolume(volprev + step)
  hs.alert.show(string.format("%.1f",device:outputVolume()),1)
end

hs.hotkey.bind(
  hyper, "-",
  function ()
    volumeAdj(-1.0)
  end
)


hs.hotkey.bind(
  hyper, "=",
  function ()
    volumeAdj(1.0)
  end
)
