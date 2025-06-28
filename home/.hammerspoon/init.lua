hyper  = {"control", "option"}

hs.hotkey.bind( hyper, "up", "Tall", function()
   local win = hs.window.focusedWindow()
   local f = win:frame()
   f.h=870
   f.y=0    
   win:setFrame(f)
end)


hs.hotkey.bind( hyper, "down", "Half", function()
   local win = hs.window.focusedWindow()
   local f = win:frame()
   f.h=872*2/3
   win:setFrame(f)
end)



