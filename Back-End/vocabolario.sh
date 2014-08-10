#!/bin/zsh
P="parole"; V="vocabolario"; VT="$V.txt"; VB="${V}base.txt"; WRA="10002 10136 10890 10905 10984 11154 16147"
FBU="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
VBU="materialefossati.altervista.org/download/${(C)V}BaseLinkato.doc"
WZU="it.wiktionary.org/w/index.php?action=raw&title="
WRU="api.wordreference.com/"
TCU="www.treccani.it/$V/"
rm -fr $P $VT; mkdir $P
curl $VBU | textutil -stdin -stdout -convert txt > $VB
cat $VB | grep -v '\\|’|\.$' | tr ' ' '\n' | grep '^[A-Z]' > $P.txt
for p in `cat $P.txt`; do
    i=$[$i+1]; if [ $[$i%1000] -eq 1 ]; then o=$[$i*6/1000]; WRK=${WRA:$o:5}; else :; fi
    p=${p:l}; PT="$P/$p.txt"; q=`urlenc -t "[{ \"name\": null, \"name~=\": \"$p\" }]"`
    curl $WRU$WRK/json/iten/$p/ | egrep -io '"[^"]*'"(( ?$p)|($p ?))"'[^"]*"' >> $PT
    curl $WZU$p | egrep -io '^(#|:)?\*[^\*{:]+[^{:]+' >> $PT
    curl $TCU$p/ | egrep -io 'm>[^<>]{3,}</e' >> $PT
    curl $FBU$q | egrep -io '.*name.*' >> $PT
done
for f in $P/*; do
    echo ${f##*/} >> $VT
    cat $f >> $VT
    echo \\n >> $VT
done
rm -fr $P* $VB
