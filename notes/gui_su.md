GUI app without output `> /dev/null 2>&1`
->kdesu
```
function guisu(){pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRES dbus-launch "$1"> /dev/null 2>&1}
```

```
alias guisu="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRES dbus-launch"

guisu dolphin .
```