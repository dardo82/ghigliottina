#!/bin/zsh
P="parole"; V="vocabolario"; B="base"; PT="$P.txt"; VT="$V.txt"; VBT="$V$B.txt"
FBU="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
VBU="materialefossati.altervista.org/download/${(C)V}${(C)B}Linkato.doc"
WZU="it.wiktionary.org/w/index.php?action=raw&title="
WRU="api.wordreference.com/12bee/json/iten"
WAU="web.archive.org/web/20140812203035"
TCU="www.treccani.it/$V/"
rm -fr $P $VT; mkdir $P
curl $VBU | textutil -stdin -stdout -convert txt > $VBT
cat $VBT | egrep -v '\\|’|\.$' | tr " " \\n | egrep '^[A-Z]' > $PT
for p in `cat $PT`; do
    p="${p:l}"; PPT="$P/$p.txt"; q=`urlenc -nt "[{ \"name\": null, \"name~=\": \"$p\" }]"`
    curl -L $WAU/$WRU/$p/ | egrep -io '"[^"]*'"(( ?$p)|($p ?))"'[^"]*"' >> $PPT
    curl $WZU$p | egrep -io '^(#|:)?\*[^\*{:]+[^{:]+' >> $PPT
    curl $TCU$p/ | egrep -io 'm>[^<>]{3,}</e' >> $PPT
    curl $FBU$q | egrep -io '.*name.*' >> $PPT
done
for f in $P/*; do
    echo ${f##*/} >> $VT
    cat $f >> $VT
    echo \\n >> $VT
done
rm -fr $P $PT $VBT
