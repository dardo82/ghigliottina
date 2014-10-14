#!/bin/zsh
P="parole"; V="vocabolario"; B="base"; PB="$P-$B"; PT="$P.txt"; VT="$V.txt"; VBT="$V-$B.txt"
rm $VT; mkdir $P
for f in $PB/*; do
    echo ${f##*/} >> $VT
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
rm -fr $P
