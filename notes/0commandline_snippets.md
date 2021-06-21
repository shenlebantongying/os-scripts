# Shell snippets

## Aggregate command info
$ file -b /{usr/,}{s,}bin/* |cut -d\  -f1,2|sort|uniq -c|sort -nr|head
$ file -b /usr/bin/* |cut -d\  -f1,2|sort|uniq -c|sort -nr|head
   5268 ELF 64-bit
    898 symbolic link
    542 POSIX shell
    170 Perl script
    112 Python script,
    100 Bourne-Again shell
     32 setuid ELF
     22 broken symbolic
     22 a /usr/bin/env
      6 directory

## gui su / kdesu replacement

alias guisu="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRES dbus-launch"

guisu dolphin .

GUI app without output `> /dev/null 2>&1`
```
function guisu(){pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRES dbus-launch "$1"> /dev/null 2>&1}
```
##

Remove all lines begin with # or //

grep -o '^[^#].*' file
