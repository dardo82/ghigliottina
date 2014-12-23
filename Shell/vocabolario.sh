#!/bin/zsh
P="parole"; V="vocabolario"; B="base"; PB="$P-$B"; PT="$P.txt"; VT="$V.txt"; VBT="$V-$B.txt"
FB="https://www.googleapis.com/freebase/v1/mqlread/?lang=%2Flang%2Fit&query="
VB="materialefossati.altervista.org/download/${(C)V}${(C)B}Linkato.doc"
WZ="it.wiktionary.org/w/index.php?action=raw&title="
WR="api.wordreference.com/12bee/json/iten"
WA="web.archive.org/web/20140812203035"
TC="www.treccani.it/$V/"
rm -fr $P $PB $VT; mkdir $P $PB
curl $VB | textutil -stdin -stdout -convert txt > $VBT
cat $VBT | egrep -v '\\|’|\.$' | tr " " \\n | egrep '^[A-Z]' | tr [A-Z] [a-z] > $PT
for p in $(cat $PT); do
    PBT="$PB/$p.txt"; q=`urlenc -nt "[{ \"name\": null, \"name~=\": \"$p\" }]"`
    curl -L $WA/$WR/$p/ | egrep -io '"[^"]*'"(( ?$p)|($p ?))"'[^"]*"' >> $PBT
    curl $WZ$p | egrep -io '^(#|:)?\*[^\*{:]+[^{:]+' >> $PBT
    curl $TC$p/ | egrep -io 'm>[^<>]{3,}</e' >> $PBT
    curl $FB$q | egrep -io '.*name.*' >> $PBT
done
for f in $PB/*; do
    echo ${f:t} >> $VT
    cat $f >> $VT
    echo >> $VT
done
gawk -v wf="$PT" -v wd="$P" 'BEGIN{while((getline l<wf)>0)s=(s RS l); split(s,wa); RS=""; FS="."}\
{for(i in wa)if($0~wa[i])print $1>>(wd"/"wa[i]".txt")}' $VT
rm $VT; cd $PB
for f in *; do
    cat ../$P/$f >> $f
    echo $f >> ../$VT
    cat $f >> ../$VT
    echo >> ../$VT
done
cd ..; rm -fr $P $PB $PT $VBT
