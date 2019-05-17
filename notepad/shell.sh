#!/bin/bash

trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ��$STEP��... Press any key to continue..."' EXIT
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'

export PATH="/c/Program Files/Docker Toolbox:$PATH"


STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

			  
			  
EOF



docker () {
  MSYS_NO_PATHCONV=1 docker.exe "$@"
}
export -f docker

if [ $# -eq 0 ]; then
  echo "Start interactive shell"
  exec "$BASH" --login -i
else
  echo "Start shell with command"
  exec "$BASH" -c "$*" 
fi

