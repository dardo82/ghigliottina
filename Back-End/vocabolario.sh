#!/bin/zsh
P="parole"; V="vocabolario"; F="fondamentale"; VF="$V-$F.pdf"; VT="$V.txt"; rm -f $VT
curl "http://www.vivante-pitagora.it/wp-content/uploads/2009/05/ALLEGATO-2.pdf" > $VF
pdftotext -raw -enc UTF-8 $VF - | awk -v RS=" " 'NR>3{print l}{l=$0}' > $P.txt
FBU="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
WZU="https://it.wiktionary.org/w/index.php?action=raw&title="; mkdir $P
for p in `cat $P.txt`; do
    n=$[$n+1]; p=${p:l}; PT="$P/$p.txt"
    if [ $n -lt 600 ]; then 
        WRK="b804a"; else
        WRK="12bee"
    fi
    TCU="http://www.treccani.it/$V/$p/"
    WRU="http://api.wordreference.com/$WRK/iten/$p"
    FBQ=`urlenc -t "[{ \"name\": null, \"name~=\": \"$p\" }]"`
    curl "$WRU" | egrep -io "W2\'>[^<>]+" >> $PT
    curl "$FBU$FBQ" | egrep -io ".*name.*" >> $PT
    curl "$TCU" | egrep -io "m>[^<>]{3,}</e" >> $PT
    curl "$WZU$p" | egrep -io "^(#|:)?\*[^\*{:]+[^{:]+" >> $PT
done
for f in $P/*; do
    echo "${f##*/}" >> $VT
    cat $f >> $VT
    echo "\n" >> $VT
done
rm -fr $P $P.txt $VF
