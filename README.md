
ghigliottina
============



Solutore Automatico Gioco Ghigliottina Eredità





WEB
---



[La Ghigliottina](http://dardo82.homepc.it/ghigliottina/)




CLI
---



``ghigliottina () { curl -s dardo82.homepc.it/cgi-bin/ghigliottina/ghigliottina.cgi\?indizi=${*// /+}|grep -o '<p>.*</p>'|sed -E 's/<\/?p>//g'; }``


Definisce la funzione.


``ghigliottina "ROSSA BIANCA GRIGLIA CRUDA GRASSA"``

Richiama la funzione.

