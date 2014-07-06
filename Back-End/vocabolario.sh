#!/bin/zsh
P="Parole"; V="Vocabolario"; B="Base"; VB="$V-$B.txt"; VT="${V:l}.txt"
FBU="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
VBU="http://materialefossati.altervista.org/download/${V}${B}Linkato.doc"
WZU="http://it.wiktionary.org/w/index.php?action=raw&title="
WRU="http://api.wordreference.com/12bee/iten/"
TCU="http://www.treccani.it/$V/"
rm -f $VT; mkdir $P
curl $VBU | textutil -stdin -stdout -convert txt > $VB
cat $VB | egrep -v '\\|’|\.$' | tr ' ' '\n' | egrep '^[A-Z]' > $P.txt
for p in `cat $P.txt`; do
    p=${p:l}; PT="$P/$p.txt"
    Q=`urlenc -t "[{ \"name\": null, \"name~=\": \"$p\" }]"`
    curl "$FBU$Q" | egrep -io ".*name.*" >> $PT
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
