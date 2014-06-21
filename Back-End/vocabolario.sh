#!/bin/sh
V="vocabolario"; P="parole"; VF="$V-fondamentale.pdf"; mkdir $P; rm -fv $V.txt
curl "www.vivante-pitagora.it/wp-content/uploads/2009/05/ALLEGATO-2.pdf" > $VF
pdftotext -raw -enc UTF-8 $VF - | awk -v RS=" " 'NR>3{print l}{l=$0}' > $P.txt
FBU="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
WZU="https://it.wiktionary.org/w/index.php?action=raw&title="
for p in `cat $P.txt`; do
    FBQ=`urlenc -t "[{ \"name\": null, \"name~=\": \"${p:l}\" }]"`
    n=$[$n+1]; PT="$P/$p.txt"
    if [ $n -lt 600 ]; then 
        WRK="b804a"; else
        WRK="12bee"
    fi
    curl "$FBU$FBQ" | egrep -io "name" >> $PT
    curl "$WZU$p" | egrep -io "^(#|:)?\*[^\*{:]+[^{:]+" >> $PT
    curl "www.treccani.it/$V/$p/" | egrep -io "m>[^<>]{3,}</e" >> $PT
    curl "api.wordreference.com/$WRK/iten/$p" | egrep -io "W2\'>[^<>]+" >> $PT
done
for f in $P/*; do
    echo "${f##*/}" >> $V.txt
    cat $f >> $V.txt
    echo "\n" >> $V.txt
done
rm -frv $P $P.txt $VF
