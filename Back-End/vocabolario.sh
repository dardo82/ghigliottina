#!/bin/sh
V="vocabolario"; P="parole"
mkdir $P; echo -en > $V.txt
FBU="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="; WDU="it.wiktionary.org/w/index.php?action=raw&title="
curl "http://www.istitutobolisani.it/risorse-mainmenu-32/materiali-scaricabili-mainmenu-30/doc_download/208-$V-fondamentale" > $P.doc
wvWare -x /usr/local/Cellar/wv/1.2.9/share/wv/wvText.xml $P.doc | awk /-/'{gsub(/[^[:alpha:]]+/,"\n"); print $0}' | sort -u -o $P.txt
for p in `cat $P.txt`; do
    n=$[$n+1]; p="${p//[][]}"; PT="$P/$p.txt"
    FBQ="%5B%7B+%22name%22%3A+null%2C+%22name~%3D%22%3A+%22${p}%22+%7D%5D"
    if [ $n -lt 600 ]; then 
        WRK="b804a"; else
        WRK="12bee"
    fi
    curl "$FBU$FBQ" | egrep "name" >> $PT
    curl "$WDU$p" | egrep -o "^(#|:)?\*[^\*{:]+[^{:]+" >> $PT
    curl "www.treccani.it/$V/$p/" | egrep -o "m>[^<>]{3,}</e" >> $PT
    curl "api.wordreference.com/$WRK/iten/$p" | egrep -o "W2\'>[^<>]+" >> $PT
done
for file in $P/*; do
    echo "${file##*/}" >> $V.txt; cat $file >> $V.txt; echo "\n"  >> $V.txt
done
rm -r $P
