ghigliottina
============



Solutore Automatico Gioco Ghigliottina Eredità





WEB
---



[La Ghigliottina](http://dardo82.homepc.it/ghigliottina "La Ghigliottina")




CLI
---



``ghigliottina() {curl dardo82.homepc.it/cgi-bin/ghigliottina/ghigliottina.cgi?indizi=`echo $*|awk '{gsub(/\ /,"+");print $0}'`|awk -F'<|>' '/\/p/{print $3}'}``


Definisce la funzione.


``ghigliottina "ROSSA BIANCA GRIGLIA CRUDA GRASSA"``

Richiama la funzione.
