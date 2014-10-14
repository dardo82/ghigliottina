#!/bin/zsh
P="parole"; V="vocabolario"; B="base"; PT="$P.txt"; VT="$V.txt"; VBT="$V-$B.txt"
FB="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
VB="materialefossati.altervista.org/download/${(C)V}${(C)B}Linkato.doc"
WZ="it.wiktionary.org/w/index.php?action=raw&title="
WR="api.wordreference.com/12bee/json/iten"
WA="web.archive.org/web/20140812203035"
TC="www.treccani.it/$V/"
rm -fr $P $VT; mkdir $P
curl -s $VB | textutil -stdin -stdout -convert txt > $VBT
cat $VBT | egrep -v '\\|’|\.$' | tr " " \\n | egrep '^[A-Z]' | tr [A-Z] [a-z] > $PT
for p in $(cat $PT); do
    PPT="$P/$p.txt"; q=`urlenc -nt "[{ \"name\": null, \"name~=\": \"$p\" }]"`
    curl -L $WA/$WR/$p/ | egrep -io '"[^"]*'"(( ?$p)|($p ?))"'[^"]*"' >> $PPT
    curl $WZ$p | egrep -io '^(#|:)?\*[^\*{:]+[^{:]+' >> $PPT
    curl $TC$p/ | egrep -io 'm>[^<>]{3,}</e' >> $PPT
    curl $FB$q | egrep -io '.*name.*' >> $PPT
done
for f in $P/*; do
    echo ${f##*/} >> $VT
    cat $f >> $VT
    echo >> $VT
done
rm -fr $P $PT $VBT
