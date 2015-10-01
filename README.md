
ghigliottina
============

[![Join the chat at https://gitter.im/dardo82/ghigliottina](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dardo82/ghigliottina?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)



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

