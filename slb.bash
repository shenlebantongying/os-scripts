# [Definations] ================================================================

# Avoid sourcing multiple times
# [[ $SLB != yes && -f ./slb.bash ]] && source ./slb.bash
SLB=yes;

SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

function _color_echo()
{
  echo -e "\e[0;$1m [slb] $2\e[0m"
}

# Note: - maybe invlid for some shell env
function red-msg(){ 
    _color_echo "31" "$1";
}

function green-msg(){ 
_color_echo "32" "$1";
}

function blue-msg(){ 
_color_echo "34" "$1";
}

# [Main] =======================================================================

cd "$SCRIPTPATH" || red-msg "Cannot cd to script path";exit 0;
green-msg "$SCRIPTPATH"