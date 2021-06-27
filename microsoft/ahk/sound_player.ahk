#SingleInstance, Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Numpad1::
SoundPlay,stupid.mp3
return

Numpad2:: 
  SoundPlay,stupid.mp3
return

; hack -> control win32 app
Numpad3:: 
  toggle:=!toggle ;toggles up and down states. 
  Run, mmsys.cpl 
  WinWait,Sound
  if toggle
      ControlSend,SysListView321,{Down 1} ; This number selects the matching audio device in the list, change it accordingly 
  Else
      ControlSend,SysListView321,{Down 2} ; This number selects the matching audio device in the list, change it accordingly
  ControlClick,&Set Default
  ControlClick,OK
return
