#!/bin/bash
INDIZI=$( echo "$QUERY_STRING" | gawk '{ gsub(/\+/," "); print substr($0,8) }' )
SOL=`./ghigliottina.sh "$INDIZI"`; TAB="../Documents/soluzione.html"
HTML=`gawk -v sol=$SOL '{ gsub(/soluzione/,sol); print $0 }' $TAB`
echo -e "Content-Type:text/html;charset=UTF-8\n\n$HTML"
