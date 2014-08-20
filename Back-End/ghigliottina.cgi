#!/bin/bash
INDIZI=$( echo -e "$QUERY_STRING" | gawk '{ gsub(/\+/," "); print substr($0,8) }' )
SOL=`./ghigliottina.sh "$INDIZI"`; HEADER="Content-Type:text/html;charset=UTF-8"
HTML=`gawk -v sol=$SOL '{ gsub(/soluzione/,sol); print $0 }' soluzione.html`
echo -e "$HEADER\n\n$HTML"
