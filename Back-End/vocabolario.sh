#!/bin/zsh
P="Parole"; V="Vocabolario"; B="Base"; VB="$V-$B.txt"; VT="${V:l}.txt"; rm -f $VT; mkdir $P
FBU="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
VBU="http://materialefossati.altervista.org/download/${V}${B}Linkato.doc"
WZU="http://it.wiktionary.org/w/index.php?action=raw&title="
TCU="http://www.treccani.it/$V/"
curl -s $VBU | textutil -stdin -stdout -convert txt > $VB
cat $VB | egrep -v '\\|’|\.$' | tr ' ' '\n' | egrep -v '\(|\)' | egrep '^[A-Z]' > $P.txt
for p in `cat $P.txt`; do
    n=$[$n+1]; p=${p:l}; PT="$P/$p.txt"
    if [ $n -lt 600 ]; then 
        WRK="b804a"; else
        WRK="12bee"
    fi
    WRU="http://api.wordreference.com/$WRK/iten/"
    FBQ=`urlenc -t "[{ \"name\": null, \"name~=\": \"$p\" }]"`
    curl "$FBU$FBQ" | egrep -io ".*name.*" >> $PT
    curl "$WRU$p" | egrep -io "W2\'>[^<>]+" >> $PT
    curl "$TCU$p" | egrep -io "m>[^<>]{3,}</e" >> $PT
    curl "$WZU$p" | egrep -io "^(#|:)?\*[^\*{:]+[^{:]+" >> $PT
done
for f in $P/*; do
    echo "${f##*/}" >> $VT
    cat $f >> $VT
    echo "\n" >> $VT
done
rm -fr $P $P.txt $VB
