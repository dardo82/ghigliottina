#!/bin/zsh
INDIZI=${${QUERY_STRING:7}//+/ }
SOL=`./ghigliottina.sh "$INDIZI"`
HEADER="Content-Type:text/html;charset=UTF-8"
HTML=${$(cat soluzione.html)/soluzione/$SOL}
echo -e "$HEADER\n\n$HTML"
